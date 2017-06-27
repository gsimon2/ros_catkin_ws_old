#!/usr/bin/env python
import rospy
import time

import cv2
import numpy as np
import math

from sensor_msgs.msg import LaserScan
from mavros_msgs.msg import OverrideRCIn

from gazebo_msgs.srv import GetWorldProperties
import numpy as np
from std_srvs.srv import Empty
import std_msgs.msg

pub = rospy.Publisher('/mavros/rc/override', OverrideRCIn, queue_size=10)


max_sim_time = 120
start_sim = False
end_sim = False
sim_timeout = False
obstacle_collision = False
sim_end_time = [0,0]

#How dratastically the rover will try to turn
# 0 = no turning
# 400 = max turning strength
max_turn_strength = 200

#how much the yaw can change for each callback
max_yaw_change_per_cb = 10

#distance at which a rover will try to stop or reverse instead of going
#	around an object
min_detection_distance = 0.45

#Number of how many partitions there will be of the lidar sweep
#	this must be an odd number
num_vision_cones = 7

#Modifies the weighting of objects as they appear further to the side 
#	of the rover
sweep_weight_factor = 1

#Modifies the weighting of the objects as they come closer to the rover
distance_weight_factor = 1

#The last known region that the rover was in
last_known_region = 'start'

#Region that rover must find to end the simulation
ending_region = 'exited_the_maze'

last_nav_cmd = {'throttle':1900,'yaw':1500}


def parse_genome(genome):
	
	global max_turn_strength
	global max_yaw_change_per_cb
	global min_detection_distance
	global num_vision_cones
	global sweep_weight_factor
	global distance_weight_factor
	
	for genome_trait in genome['behavioral']:
		#print('{}\n'.format(genome_trait))
		if 'max_turn_strength' in genome_trait:
			max_turn_strength = genome_trait['max_turn_strength']
		if 'max_yaw_change_per_cb' in genome_trait:
			max_yaw_change_per_cb = genome_trait['max_yaw_change_per_cb']
		if 'num_vision_cones' in genome_trait:
			num_vision_cones = genome_trait['num_vision_cones']
		if 'sweep_weight_factor' in genome_trait:
			sweep_weight_factor = genome_trait['sweep_weight_factor']
		if 'distance_weight_factor' in genome_trait:
			distance_weight_factor = genome_trait['distance_weight_factor']
		

	print("""Gnome - max_turn_strength {}, \n
	max_yaw_change_per_cb {}, \n
	num_vision_cones {}, \n
	sweep_weight_factor {}, \n
	distance_weight_factor {}""".format(max_turn_strength,max_yaw_change_per_cb,num_vision_cones, sweep_weight_factor,distance_weight_factor))

	

def check_vision(data, vision):
	global start_sim
	global end_sim
	global sim_timeout
	global sim_end_time
	global last_nav_cmd
	global max_yaw_change_per_cb
	global last_known_region
	global ending_region
	global obstacle_collision
		
	#print('partitioned_vision: {}'.format(vision))
	nav_cmds = {'throttle':1900,'yaw':1500}
	
	
	#Handle right half of vision (not counting center cone)
	# If objects are detected, want to decrease yaw to turn rover left
	for i in range(len(vision)/2):

		#weight for how steep to turn based off of where the object is
		#	detected in lidar sweep. Closer to center gets higher weight
		sweep_weight = sweep_weight_factor * (float((i+1)) / (len(vision)/2))
		
		#weight for how steep to turn based off of how close the object 
		#	is to the rover. Closer gets higher weight
		distance_weight = distance_weight_factor * float((data.range_max - vision[i]) / data.range_max)
		
		#If we don't see anything in this cone, don't change yaw at all
		if vision[i] == data.range_max:
			nav_cmds['yaw'] = nav_cmds['yaw']
		#turn left. Sharpest turn will happen with close objects closer to the front of the rover
		#	while distance objects off to the side will result in little to no turn
		else:
			nav_cmds['yaw'] = nav_cmds['yaw'] - (400 * sweep_weight * distance_weight)
		
		#print('Right side: \t i: {} \t sweep_weight: {} \n\t distance_weight: {} \t yaw: {}'.format(i,sweep_weight, distance_weight,nav_cmds['yaw']))



	#Handle left half of vision (not counting center cone)
	# If objects are detected, want to increase yaw to turn rover right
	for i in range(len(vision)/2 +1, len(vision)):
		
		#remap i to j for sweep_weight purposes
		#	Gives the outer cones less weight
		j = len(vision) - (i+1)

		#weight for how steep to turn based off of where the object is
		#	detected in lidar sweep. Closer to center gets higher weight
		sweep_weight = sweep_weight_factor * (float((j+1)) / (len(vision)/2))
		
		#weight for how steep to turn based off of how close the object 
		#	is to the rover. Closer gets higher weight
		distance_weight = distance_weight_factor * float((data.range_max - vision[i]) / data.range_max)
		
		#If we don't see anything in this cone, don't change yaw at all
		if vision[i] == data.range_max:
			nav_cmds['yaw'] = nav_cmds['yaw']
		#turn right. Sharpest turn will happen with close objects closer to the front of the rover
		#	while distance objects off to the side will result in little to no turn
		else:
			nav_cmds['yaw'] = nav_cmds['yaw'] + (400 * sweep_weight * distance_weight)
				
		#print('Left side: \t i: {} \t j: {} \t sweep_weight: {} \n\t distance_weight: {} \t yaw: {}'.format(i,j,sweep_weight, distance_weight,nav_cmds['yaw']))
	
	
	#Handle straight forward
	#
	#
	middle_index = int(len(vision) / 2)
	
	#weight for how steep to turn based off of how close the object 
	#	is to the rover. Closer gets higher weight
	distance_weight = distance_weight_factor * float((data.range_max - vision[middle_index]) / data.range_max)
	
	#If we don't see anything in this cone, don't change yaw at all
	if vision[middle_index] == data.range_max:
			nav_cmds['yaw'] = nav_cmds['yaw']
	else:
		#if rover is already turning right, turn right sharper based on how close the object is
		if nav_cmds['yaw'] >= 1500:
			nav_cmds['yaw'] = nav_cmds['yaw'] + (400 * distance_weight)
			
		#same but with if rover is already turning left
		else:
			nav_cmds['yaw'] = nav_cmds['yaw'] - (400 * distance_weight)
			
			
	#Make sure that yaw stays between [1500 - max_turn_strength, 1500 + max_turn_strength]
	if nav_cmds['yaw'] > 1500 + max_turn_strength:
		nav_cmds['yaw'] = 1500 + max_turn_strength			
	if nav_cmds['yaw'] < 1500 - max_turn_strength:
		nav_cmds['yaw'] = 1500 - max_turn_strength
	
	#smooth out jerkiness of turns by limiting how much yaw can change
	#	on each callback
	difference = nav_cmds['yaw'] - last_nav_cmd['yaw']
	if  abs(difference) > max_yaw_change_per_cb:
		if difference > 0:
			nav_cmds['yaw'] = last_nav_cmd['yaw'] + max_yaw_change_per_cb
		else:
			nav_cmds['yaw'] = last_nav_cmd['yaw'] - max_yaw_change_per_cb
		
	last_nav_cmd = nav_cmds
	
	
	#detect if the rover is about to hit something
	if vision[middle_index] <= min_detection_distance:
		nav_cmds['throttle'] = 1500
		print('stopping!')
		end_sim = True
		start_sim = False
		obstacle_collision = True
		

	#detect if the rover has exited the maze
	if last_known_region == ending_region:
		nav_cmds['throttle'] = 1500
		sim_end_time[0] = data.header.stamp.secs
		sim_end_time[1] = data.header.stamp.nsecs
		print("Rover finished at {} seconds and {} nanoseconds!".format(sim_end_time[0], sim_end_time[1]))
		end_sim = True
		start_sim = False
		
		
	###
	# To Do
	# -Rover skirts the edges of obstacles and sometimes catches it back wheels
	# -Detect when a collision is going to occur, put rover in reverse to gain some distance and try going around again
	
	
	#print(vision)
	#print(nav_cmds)
	return nav_cmds
	
# Takes in the data from the lidar sensor and divides it into a variable number of partitions each with the average range value for that section
#	Can optionally display a visual representation of what is being seen by the lidar
def partition_vision(data, num_vision_cones = 5, show_visual = True):
	
	#Set up cv2 image to visualize the lidar readings
	frame = np.zeros((500, 500,3), np.uint8)
	
						 
	partitioned_vision = [data.range_max for x in range(num_vision_cones)] #List of the average value in each section
	
	
	#Create a list of the upper beam index value for each vision cone
	#  IE - first cone will have values indexed from 0 to (data.lenth / num_vision_cones)
	#	    Second cone will have (data.lenth / num_vision_cones) + 1 to 2 x data.lenth / num_vision_cones)
	partition_index = [(len(data.ranges)/num_vision_cones) for i in range(num_vision_cones)]
	middle_index = int(num_vision_cones / 2) #not '+1' because indexing starts at 0 for the list
	
	# Add additional ones to middle if don't match sum.
	if sum(partition_index) < len(data.ranges):
		partition_index[middle_index] += len(data.ranges) - sum(partition_index)
	for i in range(1,num_vision_cones):
		partition_index[i] = partition_index[i] + partition_index[i-1]
		
		
	#This will be used to help draw the cv2 image 
	angle = data.angle_max
	
	# Assign received range data information and save it to a new list where the 'inf'
	#	ranges are set to the max range set for the lidar sensor being used
	range_data = [0 for x in range(len(data.ranges))]
	for i in range(len(data.ranges)):
		if data.ranges[i] == float ('Inf'):
			range_data[i] = float(data.range_max)
		else:
			range_data[i] = float(data.ranges[i])
			
		#Draw lines in cv2 image to help visualize the lidar reading
		x = math.trunc( (range_data[i] * 10)*math.cos(angle + (-90*3.1416/180)) )
		y = math.trunc( (range_data[i] * 10)*math.sin(angle + (-90*3.1416/180)) )
		
		#If the line is on a vision cone boundary draw it red otherwise blue
		if i in partition_index:
			cv2.line(frame,(250, 250),(x+250,y+250),(0,0,255),1)
		else:
			cv2.line(frame,(250, 250),(x+250,y+250),(255,0,0),1)
		angle= angle - data.angle_increment
		
	
	#Get averages for get vision cone
	for i in range(num_vision_cones):
		if i == 0:
			partitioned_vision[i] = sum(range_data[0:partition_index[i]])/len(range_data[0:partition_index[i]])	
		else:
			partitioned_vision[i] = sum(range_data[partition_index[i-1]:partition_index[i]])/len(range_data[partition_index[i-1]:partition_index[i]])
	
	#display cv2 image
	if show_visual:
		cv2.imshow('frame',frame)
		cv2.waitKey(1)
	
	return partitioned_vision
	
	
def callback(data):
	global num_vision_cones
	
	#Wait to receive genome to start simulation and start sending commands
	if start_sim is False:
		#print("No genome received yet!")
		return None
	
	#partition data ranges into sections
	partitioned_vision = partition_vision(data, num_vision_cones, False)
	
	# Use obstacle avoidance algorithm
	nav_cmds = check_vision(data, partitioned_vision)
	
	yaw = nav_cmds['yaw']
	throttle = nav_cmds['throttle']
	
	#print('Yaw: {} \t Throttle: {}'.format(yaw,throttle))

	msg = OverrideRCIn()
	msg.channels[0] = yaw
	msg.channels[1] = 0
	msg.channels[2] = throttle
	msg.channels[3] = 0
	msg.channels[4] = 0
	msg.channels[5] = 0
	msg.channels[6] = 0
	msg.channels[7] = 0
	pub.publish(msg)   

""" Callback to conduct a simulation. """
def simCallback(msg):
	global start_sim
	global obstacle_collision
	global end_sim
	global sim_timeout
	global max_sim_time
	global last_known_region
	
	print('Starting sim!')
	
	begin_time = getWorldProp().sim_time 
	
	#Get genome data
	genome_data = rospy.get_param('rover_genome')	
	
	#Parse genome received from GA
	parse_genome(genome_data)
	
	#start the simulation with this genome
	#to-do send genome to other callback function
	start_sim = True
	
	#Wait for sim to end
	while end_sim is False:
		current_time = getWorldProp().sim_time 
		total_sim_time = current_time - begin_time
		if total_sim_time >= max_sim_time:
			sim_timeout = True
			end_sim = True
		pass
	
	
	#Object found in time
	if	end_sim is True and sim_timeout is False and obstacle_collision is False:
		current_time = getWorldProp().sim_time 
		total_sim_time = current_time - begin_time
		print("Rover finished in {} seconds".format(total_sim_time))
	elif end_sim is True and sim_timeout is True:
		print('Rover failed to finish in time!')
		total_sim_time = -1
	elif end_sim is True and obstacle_collision is True:
		print('Rover hit a wall')
		total_sim_time = -2
		
	
	# Publish the resulting time on the topic.
	sim_pub.publish(total_sim_time)
	start_sim = False
	end_sim = False
	sim_timeout = False
	obstacle_collision = False
	last_known_region = 'start'
	
	print("Attempting to reset...")
	resetWorld()
	#resetSimulation()
	time.sleep(3)
	print("Reset!")


#listen to the ros_regions topic and store what region is being published
#	to global var last_known_region
def regionCallback(msg):
	global last_known_region
	last_known_region = msg.data
	#print(last_known_region)

#######################################################################	

print('Waiting for gazebo services')
rospy.wait_for_service('/gazebo/get_world_properties')
rospy.wait_for_service('/gazebo/reset_world')
rospy.wait_for_service('/gazebo/reset_simulation')
rospy.wait_for_service('/gazebo/pause_physics')
rospy.wait_for_service('/gazebo/unpause_physics')

rospy.init_node('laser_listener', anonymous=True)

rospy.Subscriber("/scan", LaserScan,callback)

print('Done!')
print('Setting up ros service proxies')

getWorldProp = rospy.ServiceProxy('/gazebo/get_world_properties', GetWorldProperties)
resetWorld = rospy.ServiceProxy('/gazebo/reset_world', Empty)
resetSimulation = rospy.ServiceProxy('/gazebo/reset_simulation', Empty)

print('Done!')
print('Starting obstacle_avoidance node and setuping topics')

# Setup the callbacks for starting and reporting results.
sim_sub = rospy.Subscriber('simulation_start', std_msgs.msg.Empty, simCallback)
sim_pub = rospy.Publisher('simulation_result', std_msgs.msg.Float64, queue_size=1)

# Setup the callback for listening to what region the rover is in
region_sub = rospy.Subscriber('ros_regions', std_msgs.msg.String, regionCallback)

print('Done! Going into spin.')

rospy.spin()
	
