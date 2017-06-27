"""
    Simple non-ga server for the rover.
"""
 
import json
import zmq
import argparse
import random
import threading
import subprocess
import os
import datetime
import copy 
import sys
import time

from GA_operators import random_value_mutation
from GA_operators import single_point_crossover

random.seed(243)

Num_evaluation_workers = 4

GA_IP_ADDR = '' #This can be provided as a command line argument, otherwise
				# the it defaults to the computers IP address
GA_SEND_PORT = 5000
GA_RECV_PORT = 5010

#Log file name
log_file_name = 'log.txt'

# How large the population size is for each generation
POP_SIZE = 30

# How many generations is this experiment going to run for
GEN_COUNT = 30

# Reports the current generation
CURRENT_GEN = 0

#Probability that an individual will have a random gene mutated
mutation_prob = 0.1

#Probability that two individuals will cross over and producing mixed offspring
cross_over_prob = 0.25

ind = {'id':0,'genome':{
					'physical':[
                    {'sensor':'lidar', 'pos':[0,0,0.4], 'orient':[0,0,0]}
                    ],
                    'behavioral':[
                    {'max_turn_strength':200}, #int, [50-400]
                    {'max_yaw_change_per_cb':15}, #int, [0-100]
                    {'num_vision_cones':7}, #int, [1-101], must be odd
                    {'sweep_weight_factor':1},#float, [0-5]
                    {'distance_weight_factor':1}#float, [0-5]
                    ]
                }, 'fitness':-1.0}


class SenderThread(threading.Thread):
	def __init__(self, threadID, socket, genomes):
		threading.Thread.__init__(self)
		self.threadID = threadID
		self.socket = socket
		self.data = genomes
		 
	def run(self):
		#print("Gnome - max_turn_strength, max_yaw_change_per_cb, num_vision_cones, sweep_weight_factor, distance_weight_factor")
		#print("\t\t\t\tStarting Sender Thread:"+str(self.threadID))
		self.send_data()
		#print("\t\t\t\tExiting Sender Thread:"+str(self.threadID))
 
	def send_data(self):
		""" Send data to worker processes. 
		
		Args:
			socket: socket to send the data out on.
				- Persistant throughout execution for now.
		"""
        
		for i in self.data:
			msg = json.dumps(i)
			self.socket.send(msg)

	def send_tear_down_msg(self):
		
		for i in range(Num_evaluation_workers):
			ind['id'] = -1
			print('Sending finish msg')
			msg = json.dumps(ind)
			self.socket.send(msg)


class GACommunicator(object):
	""" Class to handle setting up the sockets and sending/receiving genome data. """

	def __init__(self):
		#Initialize the socket for data
		
		# Setup the socket to send data out on.
		context = zmq.Context()
		self.socket = context.socket(zmq.PUSH)
		#socket.setsockopt(zmq.LINGER, 0)    # discard unsent messages on close
		self.socket.bind('tcp://{}:{}'.format(GA_IP_ADDR, GA_SEND_PORT))
		 
		# Setup the socket to read the responses on.
		self.receiver = context.socket(zmq.PULL)
		self.receiver.bind('tcp://{}:{}'.format(GA_IP_ADDR, GA_RECV_PORT))
		
	def __del__(self):
		print("Closing Sockets")
		self.socket.close()
		self.receiver.close()
	
	def send_tear_down_msg(self):
		sendThread = SenderThread(1, self.socket, '')
		sendThread.send_tear_down_msg()
		
	def send_genomes(self,genomes):
		""" Send the genomes through the sender thread to workers. 
		Args:
			genomes: list of genomes to send out.
		Returns:
			list of results containing the genome id and fitness
		"""

		return_data = []
		
		# Start a thread to send the data.
		sendThread = SenderThread(1, self.socket, genomes)
		
		sendThread.start()
		
		# Read the responses on the receiver socket.
		i = len(genomes)
		while i > 0:
			data = json.loads(self.receiver.recv())
			return_data.append({'id':data['id'], 'fitness':data['fitness']})
			i -= 1
         
		# Wait for the send thread to complete.
		sendThread.join()
		
		return return_data



class GA(object):
	def __init__(self):
		global ind
		
		self.pop_size = POP_SIZE
		
		#Initialize a population with random genomes
		self.genomes = []
		for i in range(self.pop_size):
			new_ind = copy.deepcopy(ind)
			new_ind['id'] = i
			new_ind['genome']['behavioral'][0]['max_turn_strength'] = random.randrange(50,400,1)
			new_ind['genome']['behavioral'][1]['max_yaw_change_per_cb'] = random.randrange(1,100,1)
			new_ind['genome']['behavioral'][2]['num_vision_cones'] = random.randrange(1,101,2)
			new_ind['genome']['behavioral'][3]['sweep_weight_factor'] = random.random()*5
			new_ind['genome']['behavioral'][4]['distance_weight_factor'] = random.random()*5
			self.genomes.append(new_ind)
		
		self.id_map = {k:v for k,v in zip([x['id'] for x in self.genomes],[i for i in range(self.pop_size)])}
		self.elite_ind = -1
		#self.ga_communicator = GACommunicator()
		self.child_id = self.pop_size
		
	def tear_down(self):
		self.ga_communicator.send_tear_down_msg()
		
	def calculate_fitness(self, return_data):
		#return_data = self.ga_communicator.send_genomes(self.genomes)
		
		max_fit = float('Inf')
		
		
		#print(self.id_map)
		#print(return_data)
		#print(self.genomes)
		
		for rd in return_data:
			#Filter out the negative values for genomes that either crashed in the maze or timed out
			if (rd['fitness'] == -1 or rd['fitness'] == -2):
				rd['fitness'] = float('Inf')


			self.genomes[self.id_map[rd['id']]]['fitness'] = rd['fitness']
			
			if rd['fitness'] < max_fit:
				max_fit = rd['fitness']
				self.elite_ind = copy.deepcopy(self.genomes[self.id_map[rd['id']]])
		
		
		avg_max_turn_strength = 0
		avg_max_yaw_change_per_cb = 0
		avg_num_vision_cones = 0
		avg_sweep_weight_factor = 0
		avg_distance_weight_factor = 0
		#Calculate Averages for this generation
		for single_ind in self.genomes:
			avg_max_turn_strength = avg_max_turn_strength + single_ind['genome']['behavioral'][0]['max_turn_strength']
			avg_max_yaw_change_per_cb = avg_max_yaw_change_per_cb + single_ind['genome']['behavioral'][1]['max_yaw_change_per_cb']
			avg_num_vision_cones = avg_num_vision_cones + single_ind['genome']['behavioral'][2]['num_vision_cones']
			avg_sweep_weight_factor = avg_sweep_weight_factor + single_ind['genome']['behavioral'][3]['sweep_weight_factor']
			avg_distance_weight_factor = avg_distance_weight_factor + single_ind['genome']['behavioral'][4]['distance_weight_factor']
			
		avg_max_turn_strength = avg_max_turn_strength / self.pop_size
		avg_max_yaw_change_per_cb = avg_max_yaw_change_per_cb / self.pop_size
		avg_num_vision_cones = avg_num_vision_cones / self.pop_size
		avg_sweep_weight_factor = avg_sweep_weight_factor / self.pop_size
		avg_distance_weight_factor = avg_distance_weight_factor / self.pop_size
			
		
		#print('Returned data: {}'.format(return_data))
		print('\n\n Winning Ind for generation {}:\n {}\n'.format(CURRENT_GEN,self.elite_ind))
		#print('Average turn strength: {} \nAvg yaw per cb: {} \nAvg vision cones: {} \nAvg sweep factor: {} \nAvg dist factor: {} \n\n'.format(avg_max_turn_strength,avg_max_yaw_change_per_cb
		#	,avg_num_vision_cones,avg_sweep_weight_factor,avg_distance_weight_factor))
		#print(max_fit)
		return
		
	def next_generation(self):
		""" Modify the population for the next generation. """
		child_pop = [copy.deepcopy(self.elite_ind)]
		
		# Perform tournament selection.
		for i in range(len(self.genomes)-1):
			tourn = random.sample(self.genomes,2)
			if tourn[0]['fitness'] < tourn[1]['fitness']:
				child_pop.append(copy.deepcopy(tourn[0]))
			else:
				child_pop.append(copy.deepcopy(tourn[1]))
			child_pop[-1]['id'] = self.child_id
			self.child_id += 1

		
		#Crossover
		child_pop = single_point_crossover(child_pop, cross_over_prob)

		# Mutate genes in the child genomes.
		child_pop = random_value_mutation(child_pop, mutation_prob)
		

		self.genomes = child_pop
		self.id_map = {k:v for k,v in zip([x['id'] for x in self.genomes],[i for i in range(self.pop_size)])}
		
	def ga_log(self, log):
		global CURRENT_GEN
		for ind in self.genomes:
			log.write('{}, {}, {}, {}, {}, {}, {}, {}\n'.format(CURRENT_GEN, ind['id'], ind['genome']['behavioral'][0]['max_turn_strength'], ind['genome']['behavioral'][1]['max_yaw_change_per_cb'], ind['genome']['behavioral'][2]['num_vision_cones'], ind['genome']['behavioral'][3]['sweep_weight_factor'], ind['genome']['behavioral'][4]['distance_weight_factor'],ind['fitness']))
		
	def get_pop(self):
		return self.genomes


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
	

#Create a log file
log = open('logs/{}'.format(log_file_name), 'w+')

#Write experiment parameters to log
log.write('*****Rover GA expirement*****\n')
log.write('Date:{}\n'.format(datetime.datetime.now()))
log.write('Population size:{}\n'.format(POP_SIZE))
log.write('Generation Count:{}\n'.format(GEN_COUNT))
log.write('Mutation Probability:{}\n'.format(mutation_prob))
log.write('Cross Over Probability:{}\n'.format(cross_over_prob))
log.write('*****************************\n')
log.write('Generation, ID, Max Turn Strength, Max Yaw Change per CB, Num Vision Cones, Sweep Weight Factor, Distance Weight Factor, Fitness\n')




#Initialize the socket for data

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
global CURRENT_GEN
ga= GA()

for i in range(GEN_COUNT):
	CURRENT_GEN = i
	
	genomes = ga.get_pop()
	
	return_data = []
	
	# Start a thread to send the data.
	sendThread = SenderThread(1, socket, genomes)
	
	sendThread.start()
	
	# Wait for the send thread to complete.
	sendThread.join()
	
	j = len(genomes)
	while j > 0:
		print('{}/{} genomes recv\'d'.format(len(genomes) - j, len(genomes)))
		data = json.loads(receiver.recv())
		return_data.append({'id':data['id'], 'fitness':data['fitness']})
		j -= 1
		
	ga.calculate_fitness(return_data)
	ga.ga_log(log)
	ga.next_generation()
	time.sleep(3)
	
ga.tear_down()

end_time = datetime.datetime.now()
running_time = end_time - start_time
print('Start time: {}\n End time: {}\n Running time: {}\n'.format(start_time,end_time,running_time))

