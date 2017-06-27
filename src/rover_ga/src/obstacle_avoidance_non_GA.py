#!/usr/bin/env python
import rospy

import cv2
import numpy as np
import math

from sensor_msgs.msg import LaserScan
from mavros_msgs.msg import OverrideRCIn

pub = rospy.Publisher('/mavros/rc/override', OverrideRCIn, queue_size=10)

#How dratastically the rover will try to turn
# 0 = no turning
# 400 = max turning strength
max_turn_strength = 200

#how much the yaw can change for each callback
max_difference = 10

#distance at which a rover will try to stop or reverse instead of going
#	around an object
min_detection_distance = 0.55

#Number of how many partitions there will be of the lidar sweep
#	this must be an odd number
num_vision_cones = 7


last_nav_cmd = {'throttle':1900,'yaw':1500}


def check_vision(data, vision):
	
	#print('partitioned_vision: {}'.format(vision))
	nav_cmds = {'throttle':1900,'yaw':1500}
	
	
	#Handle right half of vision (not counting center cone)
	# If objects are detected, want to decrease yaw to turn rover left
	for i in range(len(vision)/2):

		#weight for how steep to turn based off of where the object is
		#	detected in lidar sweep. Closer to center gets higher weight
		sweep_weight = float((i+1)) / (len(vision)/2)
		
		#weight for how steep to turn based off of how close the object 
		#	is to the rover. Closer gets higher weight
		distance_weight = float((data.range_max - vision[i]) / data.range_max)
		
		#If we don't see anything in this cone, don't change yaw at all
		if vision[i] == data.range_max:
			nav_cmds['yaw'] = nav_cmds['yaw']
		#turn left. Sharpest turn will happen with close objects closer to the front of the rover
		#	while distance objects off to the side will result in little to no turn
		else:
			nav_cmds['yaw'] = nav_cmds['yaw'] - (max_turn_strength * sweep_weight * distance_weight)
		
		#print('Right side: \t i: {} \t sweep_weight: {} \n\t distance_weight: {} \t yaw: {}'.format(i,sweep_weight, distance_weight,nav_cmds['yaw']))



	#Handle left half of vision (not counting center cone)
	# If objects are detected, want to increase yaw to turn rover right
	for i in range(len(vision)/2 +1, len(vision)):
		
		#remap i to j for sweep_weight purposes
		#	Gives the outer cones less weight
		j = len(vision) - (i+1)

		#weight for how steep to turn based off of where the object is
		#	detected in lidar sweep. Closer to center gets higher weight
		sweep_weight = float((j+1)) / (len(vision)/2)
		
		#weight for how steep to turn based off of how close the object 
		#	is to the rover. Closer gets higher weight
		distance_weight = float((data.range_max - vision[i]) / data.range_max)
		
		#If we don't see anything in this cone, don't change yaw at all
		if vision[i] == data.range_max:
			nav_cmds['yaw'] = nav_cmds['yaw']
		#turn right. Sharpest turn will happen with close objects closer to the front of the rover
		#	while distance objects off to the side will result in little to no turn
		else:
			nav_cmds['yaw'] = nav_cmds['yaw'] + (max_turn_strength * sweep_weight * distance_weight)
				
		#print('Left side: \t i: {} \t j: {} \t sweep_weight: {} \n\t distance_weight: {} \t yaw: {}'.format(i,j,sweep_weight, distance_weight,nav_cmds['yaw']))
	
	
	#Handle straight forward
	#
	#
	middle_index = int(len(vision) / 2)
	
	#weight for how steep to turn based off of how close the object 
	#	is to the rover. Closer gets higher weight
	distance_weight = float((data.range_max - vision[middle_index]) / data.range_max)
	
	#If we don't see anything in this cone, don't change yaw at all
	if vision[middle_index] == data.range_max:
			nav_cmds['yaw'] = nav_cmds['yaw']
	else:
		#if rover is already turning right, turn right sharper based on how close the object is
		if nav_cmds['yaw'] >= 1500:
			nav_cmds['yaw'] = nav_cmds['yaw'] + (max_turn_strength * distance_weight)
			if nav_cmds['yaw'] > 1900:
				nav_cmds['yaw'] = 1900
		#same but with if rover is already turning left
		else:
			nav_cmds['yaw'] = nav_cmds['yaw'] - (max_turn_strength * distance_weight)
			if nav_cmds['yaw'] < 1100:
				nav_cmds['yaw'] = 1100
				
	
	
	#smooth out jerkiness of turns by limiting how much yaw can change
	#	on each callback
	global last_nav_cmd
	global max_difference
	difference = nav_cmds['yaw'] - last_nav_cmd['yaw']
	if  abs(difference) > max_difference:
		if difference > 0:
			nav_cmds['yaw'] = last_nav_cmd['yaw'] + max_difference
		else:
			nav_cmds['yaw'] = last_nav_cmd['yaw'] - max_difference
		
	last_nav_cmd = nav_cmds
	
	
	
	#detect if the rover is about to hit something

	if vision[middle_index] <= min_detection_distance:
		nav_cmds['throttle'] = 1500
		print('stopping!')	
	
	
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
	
		
	#partition data ranges into sections
	partitioned_vision = partition_vision(data, num_vision_cones, True)
	
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
	

def laser_listener():
    rospy.init_node('laser_listener', anonymous=True)
    
    rospy.Subscriber("/scan", LaserScan,callback)
    rospy.spin()

if __name__ == '__main__':
    laser_listener()
