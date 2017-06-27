import os
import fileinput
import subprocess
import socket




# Get host name
str_host_name = socket.gethostname()


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



