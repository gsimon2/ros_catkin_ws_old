"""
    Simple non-ga server for the basicbot.
"""
 
import json
import zmq
import argparse
import random
import threading
import subprocess
import os
import datetime

random.seed(10)

Num_evaluation_workers = 2

GA_IP_ADDR = '127.0.0.1'
GA_SEND_PORT = 5000
GA_RECV_PORT = 5010

# How many genomes to test sending
test_genome_num = 10

 
class senderThread(threading.Thread):
    def __init__(self, threadID, socket, num_genomes=10):
        threading.Thread.__init__(self)
        self.threadID = threadID
        self.socket = socket
        self.num_genomes = num_genomes
 
    def run(self):
        print("Gnome - center_spin_thresh, center_drive_thresh, center_stop_thresh, stopping_thresh")
        print("\t\t\t\tStarting Sender Thread:"+str(self.threadID))
        self.send_data()
        print("\t\t\t\tExiting Sender Thread:"+str(self.threadID))
 
    def send_data(self):
        """ Send data to worker processes. 
 
        Args:
            socket: socket to send the data out on.
                - Persistant throughout execution for now.
        """
        ind = {'id':0,'genome':{
					'physical':[
                    {'sensor':'lidar', 'pos':[0,0,0.4], 'orient':[0,0,0]}
                    ],
                    'behavioral':[
                    {'test':0}
                    ]
                }, 'fitness':-1.0}
        
        for i in range(self.num_genomes/2+1):
            ind['id'] = i+50
            ind['genome']['behavioral'][0]['test'] = 0.4 + i * 0.1
            msg = json.dumps(ind)
            print(msg)
            socket.send(msg)
            
        for i in range(self.num_genomes/2+1,self.num_genomes):
            ind['id'] = i+50
            ind['genome']['physical'][0]['pos'][2] = 0.4 + i * 0.05
            msg = json.dumps(ind)
            print(msg)
            socket.send(msg)
            
        for i in range(Num_evaluation_workers):
            ind['id'] = -1
            print('Sending finish msg')
            msg = json.dumps(ind)
            socket.send(msg)


# Set up arg parser
parser = argparse.ArgumentParser(description='Test set up for a GA to use the rover simulation framework. Creates genomes and sends them over a TCP socket, then waits for responses from evaluation workers')
parser.add_argument('-d', '--debug', action='store_true', help='Print extra output to terminal')
parser.add_argument('-ip', '--ga_ip_addr', type=str, help='IP address that the GA is running on')
parser.add_argument('-sp', '--ga_send_port', type=int, help='Port number that the GA is sending the genomes on')
parser.add_argument('-rp', '--ga_recv_port', type=int, help='Port number that the GA is receiving the results on')
args= parser.parse_args()

#Parse Args
if args.debug:
	print('Debugging option has been turned on!')      
 
if args.ga_ip_addr is not None:
	print('Provided IP = {}'.format(args.ga_ip_addr))
	GA_IP_ADDR = args.ga_ip_addr
else:
	#Get the IP address of the machine running this script
	str_host_IP = subprocess.check_output('hostname -I',stderr=subprocess.STDOUT,shell=True)
	print('Found Host IP = {}'.format(str_host_IP))
	GA_IP_ADDR = str_host_IP

if args.ga_send_port is not None:
	GA_SEND_PORT = args.ga_send_port

if args.ga_recv_port is not None:
	GA_RECV_PORT = args.ga_recv_port
	

# Setup the socket to send data out on.
context = zmq.Context()
socket = context.socket(zmq.PUSH)
#socket.setsockopt(zmq.LINGER, 0)    # discard unsent messages on close
socket.bind('tcp://{}:{}'.format(GA_IP_ADDR, GA_SEND_PORT))
 
# Setup the socket to read the responses on.
receiver = context.socket(zmq.PULL)
receiver.bind('tcp://{}:{}'.format(GA_IP_ADDR, GA_RECV_PORT))
 
print("Press Enter when the workers are ready: ")
_ = raw_input()
print("Sending tasks to workers")

start_time = datetime.datetime.now()

# Start a thread to send the data.
sendThread = senderThread(1, socket, num_genomes=test_genome_num)
sendThread.start()
 
# Read the responses on the receiver socket.
i = test_genome_num
while i > 0:
    data = json.loads(receiver.recv())
    print("Fitness: {}, Genome ID: {}, Host: {}".format(data['fitness'],data['id'],data['ns']))
    i -= 1
 
# Wait for the send thread to complete.
sendThread.join()
 
print("Closing Socket..")
socket.close()
receiver.close()
print("...Closed!")
end_time = datetime.datetime.now()
running_time = end_time - start_time
print('Start time: {}\n End time: {}\n Running time: {}\n'.format(start_time,end_time,running_time))
print("Press Enter to close script: ")
_ = raw_input()
