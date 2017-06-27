#!/usr/bin/env python
import os
import argparse
import json
import zmq
import rospy
import time
import subprocess
import socket
import datetime

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

BEHAVIOR_SCRIPT = 'obstacle_avoidance_GA_v1-1.py'
LAUNCH_FILE = 'test.launch'

max_single_sim_running_time = 360 #In real-time seconds

HEADLESS = 'true'
GUI = 'false'

# Set up arg parser
parser = argparse.ArgumentParser(description='Individual simulation instance controller / transporter. Receives genomes, makes modifications to personal copy of rover.urdf, and spawns all necessary processes to run the evaluation')
parser.add_argument('-d', '--debug', action='store_true', help='Print extra output to terminal, spawn subprocesses in xterm for seperated process outputs')
parser.add_argument('-sp', '--ga_send_port', type=int, help='Port number that the GA is sending the genomes on')
parser.add_argument('-rp' , '--ga_recv_port', type=int, help='Port number that the GA is receiving the results on')
parser.add_argument('-ip' , '--ga_ip_addr', type=str, help='IP address that the GA is running on')
parser.add_argument('-bs' , '--behavior_script', type=str, help='behaviour script controlling the rover')
parser.add_argument('-lf' , '--launch_file', type=str, help='the launch file that is to be used')
parser.add_argument('-gui', '--graphics', action='store_true', help='Start gazebo gui for each simulation')
parser.add_argument('--less_wait',action='store_true',help='minimize the sleep timers to make running on local machines faster. This is cause problems when running on remote VMs')

args= parser.parse_args()

if args.ga_send_port is not None:
	GA_SEND_PORT = args.ga_send_port

if args.ga_recv_port is not None:
	GA_RECV_PORT = args.ga_recv_port
	
if args.ga_ip_addr is not None:
	GA_IP_ADDR = args.ga_ip_addr

if args.behavior_script is not None:
	BEHAVIOR_SCRIPT = args.behaviour_script
	
if args.launch_file is not None:
	LAUNCH_FILE = args.launch_file
	
if args.graphics is True:
	print('Turning on Gazebo GUI')
	HEADLESS = 'false'
	GUI = 'true'

print('Behavior script being used: {}'.format(BEHAVIOR_SCRIPT))

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

print("GA is running at IP: {} \n Sending port: {} \n Receiving port: {} \n".format(GA_IP_ADDR, GA_SEND_PORT, GA_RECV_PORT))

# Setup the ROS topics for communicating with connected nodes.
rospy.init_node('transporter',anonymous=True)
pub = rospy.Publisher('simulation_start', std_msgs.msg.Empty, queue_size=1)
sub = rospy.Subscriber('simulation_result', std_msgs.msg.Float64, callback)


# Get host name
str_host_name = socket.gethostname()


# Set up subprocesses
if args.debug is False:
	cmd_str = "echo 'starting subprocess'"
	mavproxy = subprocess.Popen(cmd_str, stdout=subprocess.PIPE, shell=True)
	launch_file = subprocess.Popen(cmd_str, stdout=subprocess.PIPE, shell=True)
	rover_behavior = subprocess.Popen(cmd_str, stdout=subprocess.PIPE, shell=True)


last_physical_genome = []
different_physical_genome = True
recv_first_msg = False
dependent_software_crash = False #Some of the software that is called by this script has a tendency to crash (looking at you gazebo), so if it does we need a way to reset it

while True:
	
	# Reset the simulation enviroment if one of the dependent programs crashed
	if dependent_software_crash == True:
		print('Resetting simulation because of crashed program')
		cmd_str = "pkill -1 -f {}".format(BEHAVIOR_SCRIPT)
		os.system(cmd_str)
		last_physical_genome = []
		cmd_str = "pkill -1 -f region_events_node"
		os.system(cmd_str)
	else:
		# Get data off the pipe from the external source
		print('Waiting for data from GA...')
		data = 'stuff'
		data = json.loads(receiver.recv())
		print('Transporter: Received: {}'.format(data))
	
	#start program timer on first recv'd msg
	if recv_first_msg == False:
		start_time = datetime.datetime.now()
		recv_first_msg = True

	
	#Check for ending msg
	if data['id'] == -1:
		break
	
	#Check to see if received physical genome is different from last received
	if data['genome']['physical'] != last_physical_genome:
		print("		Received different physical genome!")
		last_physical_genome = data['genome']['physical']
		different_physical_genome = True
	else:
		print("	 	Same pyhsical genome!")
		different_physical_genome = False
	
	
	#If Different pyhsical genome tear down everything and restart
	if different_physical_genome is True:
		
		# Tear down this simulation instance
		cmd_str = "killall -9 gzserver gzclient xterm mavproxy.py"
		os.system(cmd_str)
		if args.debug is False:
			mavproxy.kill()
			launch_file.kill()
			rover_behavior.kill()
			mavproxy.wait()
			launch_file.wait()
			rover_behavior.wait()
		time.sleep(3)
	
		#Create a copy of the base rover file for this instance
		str_rover_file = copy_base_rover_file(str_host_name)
		
		#Build rover sensors based off recveived genome
		for genome_trait in data['genome']['physical']:
			print('{}\n'.format(genome_trait))
			if 'lidar' in genome_trait['sensor']:
				print("Adding a lidar sensor to the rover")
				#Add sensors based off genome
				add_lidar(str_rover_file, genome_trait['pos'], genome_trait['orient'])
	
		time.sleep(1)
		
		
		# Start all needed processes
		# Start MAVProxy
		if args.debug:
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
		else:
			cmd_str = """source ~/simulation/ros_catkin_ws/devel/setup.bash;
				cd ~/simulation/ardupilot/APMrover2;
				echo \"param load ~/simulation/ardupilot/Tools/Frame_params/3DR_Rover.param\";
				echo
				echo \" (For manual control) - param set SYSID_MYGCS 255\";
				echo
				echo \" (For script control) - param set SYSID_MYGCS 1\";
				../Tools/autotest/sim_vehicle.sh -j 4 -f Gazebo"""
			mavproxy = subprocess.Popen(cmd_str, stdout=subprocess.PIPE, shell=True)
		
		#Give time to start up Mavproxy and Ardupilot (takes a while since Ardupilots sim_vehicle script calls xterm to start the ardupilot scripts)
		str_PID = ''
		while(str_PID == ''):
			try:
				str_PID = subprocess.check_output('pidof APMrover2.elf',stderr=subprocess.STDOUT,shell=True)
			except Exception:
				pass
			time.sleep(0.5)
		print('Started MAVProxy!')
		time.sleep(4)
	
		# Run launch file
		if args.debug:
			cmd_str = "xterm -hold -e 'roslaunch rover_ga {} model:={} gui:={} headless:={}'&".format(LAUNCH_FILE, str_rover_file, GUI, HEADLESS)
			os.system(cmd_str)
			time.sleep(1)
		else:
			cmd_str = 'roslaunch rover_ga {} model:={} gui:={} headless:={}'.format(LAUNCH_FILE, str_rover_file, GUI, HEADLESS)
			launch_file = subprocess.Popen(cmd_str, stdout=subprocess.PIPE, shell=True)
		print('Started launch file!')
	
		#Start Rover behavior script
		if args.debug:
			cmd_str = "xterm -e 'rosrun rover_ga {}'&".format(BEHAVIOR_SCRIPT)
			os.system(cmd_str)
		else:
			cmd_str = 'rosrun rover_ga {}'.format(BEHAVIOR_SCRIPT)
			rover_behavior = subprocess.Popen(cmd_str, stdout=subprocess.PIPE, shell=True)
	
		
		#Give time for everything to start up
		if args.less_wait:
			time.sleep(10)
		else:
			if args.debug:
				time.sleep(27) #spawning a bunch of xterms for debugging takes longer than subprocesses
			else:
				time.sleep(17)

	#End If different physical genome
	
	

	
	print('Loading received genome into ros param and setting ready msg')
	# Load the data into a parameter in ROS
	rospy.set_param('rover_genome', data['genome'])
	
	# Send a ready message on the topic to the behavior node
	pub.publish(std_msgs.msg.Empty())
	
	print('Done! Entering sleep onto sim evaluation is complete.')
	
	# Wait for a result to return from the basicbot node
	# TODO: Remove this spinning while loop with a different construct.
	# Dependent upon the internal structure of ROS nodes!
	# TODO: get the dependent software crash reset working wihtout having to send back a -1 result
	this_eval_start = datetime.datetime.now()
	while evaluation_result == '':
		current_time = datetime.datetime.now()
		if (current_time - this_eval_start).total_seconds() > max_single_sim_running_time:
			evaluation_result = -3
			last_physical_genome = []
			#dependent_software_crash = True
			break
		time.sleep(0.5)
	
	#If crashed program jump to start of loop without sending eval result
	if dependent_software_crash == True:
		evaluation_result = ''
		continue
	else:
		# Transmit the result back to the external source
		msg = json.dumps({'id':data['id'],'fitness':evaluation_result, 'ns':str_host_name, 'name':rospy.get_name()})
		sender.send(msg)
		print (rospy.get_namespace(), evaluation_result)
		evaluation_result = ''
	
	
#clean up
# Tear down this simulation instance
cmd_str = "killall -9 gzserver gzclient xterm roscore rosmaster rosout mavproxy.py python"
os.system(cmd_str)
cmd_str = "pkill -1 -f {}".format(BEHAVIOR_SCRIPT)
os.system(cmd_str)
cmd_str = "pkill -1 -f region_events_node"
os.system(cmd_str)
if args.debug is False:
	mavproxy.kill()
	launch_file.kill()
	rover_behavior.kill()
	mavproxy.wait()
	launch_file.wait()
	rover_behavior.wait()
end_time = datetime.datetime.now()
time.sleep(1)
running_time = end_time - start_time
print('Start time: {}\n End time: {}\n Running time: {}\n'.format(start_time,end_time,running_time))
print('Exiting...')

	
    


