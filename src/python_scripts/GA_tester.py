#!/usr/bin/env python
import os
import argparse
import json
import zmq
import time
import subprocess
import socket
import datetime
import random


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
	GA_RECV_PORT = args.ga_recv_port
	
if args.ga_ip_addr is not None:
	GA_IP_ADDR = args.ga_ip_addr

# Setup the contexts for communicating with the outside server. 
recv_addr_str = 'tcp://{}:{}'.format(GA_IP_ADDR, GA_SEND_PORT)
send_addr_str = 'tcp://{}:{}'.format(GA_IP_ADDR, GA_RECV_PORT)

context = zmq.Context()
receiver = context.socket(zmq.PULL)
receiver.connect(recv_addr_str)
sender = context.socket(zmq.PUSH)
sender.connect(send_addr_str)

str_host_name = 'testing'

while(True):
		# Get data off the pipe from the external source
		print('Waiting for data from GA...')
		data = 'stuff'
		data = json.loads(receiver.recv())
		print('Transporter: Received: {}'.format(data))
		
		#Check for ending msg
		if data['id'] == -1:
			break
		
		evaluation_result = random.randrange(1,100,1)
		
		# Transmit the result back to the external source
		msg = json.dumps({'id':data['id'],'fitness':evaluation_result, 'ns':str_host_name})
		time.sleep(0.5)
		sender.send(msg)
		evaluation_result = ''
