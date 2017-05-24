#!/usr/bin/env python
import rospy
import time

import numpy as np
from std_srvs.srv import Empty
import std_msgs.msg
from sensor_msgs.msg import LaserScan
from mavros_msgs.msg import OverrideRCIn

from gazebo_msgs.srv import GetWorldProperties

pub = rospy.Publisher('/mavros/rc/override', OverrideRCIn, queue_size=10)


max_sim_time = 30


#Straight = 1500
#Left = [1100-1499]
#Right = [1501-1900]
yaw = 1400

throttle = 1900

collision_dist = 0.33

start_sim = False
end_sim = False
sim_timeout = False
sim_end_time = [0,0]

def callback(msg):
	
	global start_sim
	global end_sim
	
	if start_sim is False:
		#print("No genome received yet!")
		return None
	
	#print(msg.angle_max)
	#print(msg.ranges)
	
	formatted_msg = {'time':str(msg.header.stamp.secs)+"."+str(msg.header.stamp.nsecs), 'sum_ranges':sum(msg.ranges), 'ranges':msg.ranges}
	
	
	# Correct for infinite values by replacing them with max range.
	formatted_msg = {'time':str(msg.header.stamp.secs)+"."+str(msg.header.stamp.nsecs), 'sum_ranges':sum([float("{0:.6f}".format(i)) if i != np.inf else msg.range_max for i in msg.ranges]), 'ranges':[float("{0:.6f}".format(i)) if i != np.inf else msg.range_max for i in msg.ranges]}


	#print(formatted_msg)

	""" Divide the vision into three sections and report on their average sum. """

	partitioned_vision = {'right':10.0,'left':10.0,'center':10.0}
	
	
	
	# If no message yet return blank
	if formatted_msg:
		partitions = [len(formatted_msg['ranges'])/3 for i in range(3)]
		#print(partitions)
		
		# Add additional ones to middle if don't match sum.
		if sum(partitions) < len(formatted_msg['ranges']):
				partitions[1] += len(formatted_msg['ranges']) - sum(partitions)

		# Calculate the index offsets.
		partitions[1] = partitions[0] + partitions[1]
		partitions[2] = partitions[1] + partitions[2]
		
		
		# Get right, center, and left averages.
		partitioned_vision['right'] = sum(formatted_msg['ranges'][0:partitions[0]])/len(formatted_msg['ranges'][0:partitions[0]])
		partitioned_vision['center'] = sum(formatted_msg['ranges'][partitions[0]:partitions[1]])/len(formatted_msg['ranges'][partitions[0]:partitions[1]])
		partitioned_vision['left'] = sum(formatted_msg['ranges'][partitions[1]:partitions[2]])/len(formatted_msg['ranges'][partitions[1]:partitions[2]])
		
		
			
		#print(partitioned_vision)
            
            
	#Steer towards single object
	#to-do - make yaw depenedent on how high the intensity value is on left or right
	global yaw
	global throttle
	throttle = 1900
	
	#No object in site scan area
	if partitioned_vision['right'] == msg.range_max and partitioned_vision['left'] == msg.range_max and partitioned_vision['center'] == msg.range_max:
		yaw = 1900 - int(msg.header.stamp.secs)
	
	elif partitioned_vision['left'] != msg.range_max:
		yaw = 1300
	elif partitioned_vision['right'] != msg.range_max:
		yaw = 1700
		
	#detected object straight forward
	elif partitioned_vision['right'] == msg.range_max and partitioned_vision['left'] == msg.range_max and partitioned_vision['center'] != msg.range_max:
		yaw = 1400
	
		
	#print("yaw: {}".format(yaw))
	
	
	#to-do - Detect object and end sim
	#Possibly look through msg.ranges for 0 (or close to 0) value
	
	if min(msg.ranges) < collision_dist:
		throttle = 1500
		global sim_end_time
		sim_end_time[0] = msg.header.stamp.secs
		sim_end_time[1] = msg.header.stamp.nsecs
		print("Found object at {} seconds and {} nanoseconds!".format(sim_end_time[0], sim_end_time[1]))
		end_sim = True
		start_sim = False
		
		
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

def simCallback(msg):
	global start_sim
	global end_sim
	global sim_timeout
	global max_sim_time
	

	begin_time = getWorldProp().sim_time 
	
	""" Callback to conduct a simulation. """
	genome_data = rospy.get_param('rover_genome')
	print("                 Got genome data of:"+str(genome_data))
	
	
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
	if	end_sim is True and sim_timeout is False:
		current_time = getWorldProp().sim_time 
		total_sim_time = current_time - begin_time
		print("Found object at in {} seconds".format(total_sim_time))
	elif end_sim is True and sim_timeout is True:
		print('Rover failed to find object in time!')
		total_sim_time = -1
		
	
	# Publish the resulting time on the topic.
	sim_pub.publish(total_sim_time)
	start_sim = False
	end_sim = False
	sim_timeout = False
    
	print("Attempting to reset...")
	resetWorld()
	#resetSimulation()
	time.sleep(1)
	print("Reset!")
	
	
#######################################################################

print('Waiting for gazebo services')
rospy.wait_for_service('/gazebo/get_world_properties')
rospy.wait_for_service('/gazebo/reset_world')
rospy.wait_for_service('/gazebo/reset_simulation')
rospy.wait_for_service('/gazebo/pause_physics')
rospy.wait_for_service('/gazebo/unpause_physics')

print('Done!')
print('Setting up ros service proxies')

getWorldProp = rospy.ServiceProxy('/gazebo/get_world_properties', GetWorldProperties)
resetWorld = rospy.ServiceProxy('/gazebo/reset_world', Empty)
resetSimulation = rospy.ServiceProxy('/gazebo/reset_simulation', Empty)

print('Done!')
print('Starting object_finder node and setuping topics')
rospy.init_node('object_finder', anonymous=True)
    
rospy.Subscriber("/scan", LaserScan,callback)
	
# Setup the callbacks for starting and reporting results.
sim_sub = rospy.Subscriber('simulation_start', std_msgs.msg.Empty, simCallback)
sim_pub = rospy.Publisher('simulation_result', std_msgs.msg.Float64, queue_size=1)

print('Done! Going into spin.')
rospy.spin()


