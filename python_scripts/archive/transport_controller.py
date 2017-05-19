#!/usr/bin/env python
import os
import argparse
import json
import zmq
import rospy
import time
import subprocess
import socket

import std_msgs.msg

from add_sensor_functions import add_lidar
from add_sensor_functions import copy_base_rover_file

evaluation_result = ''

def callback(data):
    """ Handle the return of adding information. """
    global evaluation_result

    evaluation_result = data.data

GA_SEND_PORT = 5000
GA_RECV_PORT = 5010
GA_IP_ADDR = '127.0.0.1'


# Set up arg parser
parser = argparse.ArgumentParser(description='Individual simulation instance controller / transporter. Receives genomes, makes modifications to personal copy of rover.urdf, and spawns all necessary processes to run the evaluation')
parser.add_argument('-sp', '--ga_send_port', type=int, help='Port number that the GA is sending the genomes on')
parser.add_argument('-rp' , '--ga_recv_port', type=int, help='Port number that the GA is receiving the results on')
parser.add_argument('-ip' , '--ga_ip_addr', type=str, help='IP address that the GA is running on')

args= parser.parse_args()

if args.ga_send_port is not None:
	GA_SEND_PORT = args.ga_send_port

if args.ga_recv_port is not None:
	GA_RECV_PORT = args.ga_recv_portevaluation_result
	
if args.ga_ip_addr is not None:
	GA_IP_ADDR = args.ga_ip_addr

print("GA is running at IP: {} \n Sending port: {} \n Receiving port: {} \n".format(GA_IP_ADDR, GA_SEND_PORT, GA_RECV_PORT))


# Setup the contexts for communicating with the outside server. 
recv_addr_str = 'tcp://{}:{}'.format(GA_IP_ADDR, GA_SEND_PORT)
send_addr_str = 'tcp://{}:{}'.format(GA_IP_ADDR, GA_RECV_PORT)

context = zmq.Context()
receiver = context.socket(zmq.PULL)
receiver.connect(recv_addr_str)
sender = context.socket(zmq.PUSH)
sender.connect(send_addr_str)


#start ros
roscore = subprocess.Popen('roscore')
time.sleep(1)

# Setup the ROS topics for communicating with connected nodes.
rospy.init_node('transporter',anonymous=True)
pub = rospy.Publisher('simulation_start', std_msgs.msg.Empty, queue_size=1)
sub = rospy.Subscriber('simulation_result', std_msgs.msg.Float64, callback)


# Get host name
str_host_name = socket.gethostname()

while True:
	# Get data off the pipe from the external source
	print('Waiting for data from GA...')
	data = 'stuff'
	data = json.loads(receiver.recv())
	print('Transporter: Received: {}'.format(data))
	
	
	#Create a copy of the base rover file for this instance
	str_rover_file = copy_base_rover_file(str_host_name)
	
	
	#Build rover sensors based off recveived genome
	for genome_trait in data['genome']['physical']:
		print('{}\n'.format(genome_trait))
		if 'lidar' in genome_trait['sensor']:
			print("Adding a lidar sensor to the rover")
			#Add sensors based off genome
			add_lidar(str_rover_file, genome_trait['pos'], genome_trait['orient'])
	
	
# Start all needed processes
	# Start MAVProxy
	cmd_str = """xterm -title 'MAVProxy' -hold  -e '
		source ~/simulation/ros_catkin_ws/devel/setup.bash;
		cd ~/simulation/ardupilot/APMrover2;
		echo \"param load ~/simulation/ardupilot/Tools/Frame_params/3DR_Rover.param\";
		echo
		echo \" (For manual control) - param set SYSID_MYGCS 255\";
		echo
		echo \" (For script control) - param set SYSID_MYGCS 1\";
		../Tools/autotest/sim_vehicle.sh -j 4 -f Gazebo'&"""
	os.system(cmd_str)
	time.sleep(1)
	
	print('Started MAVProxy!')
	
	# Run launch file
	cmd_str = "xterm -e 'roslaunch rover_ga msu.launch model:={}'&".format(str_rover_file)
	os.system(cmd_str)
	
	print('Started launch file!')
	
	#Start Rover behavior script
	cmd_str = "xterm -e 'rosrun rover_ga object_finder.py'&"
	os.system(cmd_str)
	
	#Give time for everything to start up
	time.sleep(10)
	
	print('Loading received genome into ros param and setting ready msg')
	# Load the data into a parameter in ROS
	rospy.set_param('rover_genome', data['genome'])
	
	# Send a ready message on the topic to the basicbot node
	pub.publish(std_msgs.msg.Empty())
	
	print('Done! Entering sleep onto sim evaluation is complete.')
	
	# Wait for a result to return from the basicbot node
	# TODO: Remove this spinning while loop with a different construct.
	# Dependent upon the internal structure of ROS nodes!
	while evaluation_result == '':
		time.sleep(0.5)
	
	# Transmit the result back to the external source
	msg = json.dumps({'id':data['id'],'fitness':evaluation_result, 'ns':str_host_name, 'name':rospy.get_name()})
	sender.send(msg)
	print (rospy.get_namespace(), evaluation_result)
	evaluation_result = ''
	
	# Tear down this simulation instance
	cmd_str = "killall -9 gzserver gzclient xterm"
	
	#cmd_str = 'pkill xterm'
	os.system(cmd_str)
	time.sleep(2)
	
    


