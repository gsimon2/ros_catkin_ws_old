#!/usr/bin/env python
import os
import fileinput
import subprocess

# Copies the base_rover.urdf file in the same directory with name of the host computer name + '_rover.urdf'
# 	param - str_host_name - string of the name of the host computer
#	returns - str_rover_file - string of the complete path for the new file
def copy_base_rover_file(str_host_name):
	str_rover_file_name = str_host_name + '_rover.urdf' #New file name = This computers name + '_rover.urdf'
	str_user_home_dir = 'locate ~ --limit 1'
	str_user_home_dir = subprocess.check_output(str_user_home_dir,stderr=subprocess.STDOUT,shell=True) #gets the home directory of the current user
		#needs this if multiple users on the same machine have the ros_catkin directory
	
	str_user_home_dir = str_user_home_dir.rstrip() #Remove newline character from returned path
	
	str_rover_file_path = "$(dirname $(locate -ir '{}/.*base_rover.urdf'))".format(str_user_home_dir) #Gets the dir name (path) that the base_rover.urdf file is in
		#locate -ir  = use regex expression to find a file that starts with the users home dir and ends with base_rover.urdf
	
	str_rover_file = str_rover_file_path + '/' + str_rover_file_name
	
	cmd_str = 'cp $(find ~ -name base_rover.urdf) ' +  str_rover_file #Copy the file
	os.system(cmd_str)
	
	str_rover_file = subprocess.check_output('find ~ -name {}'.format(str_rover_file_name),stderr=subprocess.STDOUT,shell=True) #gets the abs path from OS
	str_rover_file = str_rover_file.rstrip() #Remove newline character from returned path
	
	print("Rover model file: {}".format(str_rover_file))
	return str_rover_file



# Opens rover .urdf file, splits it where the add sensors tag is, and adds the code for a lidar sensor
#	param - str_rover_file - string of the rover .urdf file path
#	param - pos - position of sensor in respect to rover
#	param - orient  orientation of sensor in respect to rover
def add_lidar(str_rover_file, pos = [0,0,0.4], orient = [0,0,0]):
	#print('Modifying file: {}!'.format(str_rover_file))
	
	with open(str_rover_file) as f:
		content = f.read()
		
	x = content.split('<!-- ADD SENSORS HERE -->')
	
	lidar_sensor = """<!-- ADD SENSORS HERE -->
	
	<xacro:include filename="$(find ardupilot_sitl_gazebo_plugin)/urdf/sensors/lidar_sensor.urdf.xacro" />
<xacro:lidar_sensor
	name="lidar1"
	parent="chassis"
	ros_topic="sonar_front"
	update_rate="10"
	min_range="0.06"
	max_range="20.0"
	field_of_view_horizontal="${{180*M_PI/180}}"
	field_of_view_vertical="${{1*M_PI/180}}"
	ray_count_horizontal="542"
	ray_count_vertical="1"
	sensor_mesh="lidar_lite_v2_withRay/meshes/lidar_lite_v2_withRay.dae">
	<origin xyz="{} {} {}" rpy="{} {} {}"/>
</xacro:lidar_sensor>
""".format(pos[0], pos[1], pos[2], orient[0], orient[1], orient[2])

	content = x[0] + lidar_sensor + x[1]
	
	with open(str_rover_file, "w") as f:
		f.write(content)
