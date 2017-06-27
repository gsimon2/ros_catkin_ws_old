import random
import datetime

random.seed(datetime.datetime.now())

num_traits = 6

def single_point_crossover(population, cross_over_prob):
	for i in range(len(population)-1):
		couple = random.sample(population,2)
		
		#pick a random spot for single point cross over
		if random.random() < cross_over_prob:
			split = random.randrange(0,num_traits,1)
			new_genome = couple[0]['genome']['behavioral'][0:split] + couple[1]['genome']['behavioral'][-1*(num_traits-split):]
			new_genome2 = couple[1]['genome']['behavioral'][0:split] + couple[0]['genome']['behavioral'][-1*(num_traits-split):]
			
			couple[0]['genome']['behavioral'] = new_genome
			couple[1]['genome']['behavioral'] = new_genome2
	
	return population

def random_value_mutation(population, mutation_prob):
	for ind in population:
		if random.random() < mutation_prob:
			#Select a gene that is to be mutated
			gene_num = random.randrange(0, num_traits,1)

			if gene_num == 0:
				ind['genome']['behavioral'][0]['max_turn_strength'] = random.randrange(50,400,1)
			if gene_num == 1:
				ind['genome']['behavioral'][1]['max_yaw_change_per_cb'] = random.randrange(1,100,1)
			if gene_num == 2:
				ind['genome']['behavioral'][2]['num_vision_cones'] = random.randrange(1,101,2)
			if gene_num == 3:
				ind['genome']['behavioral'][3]['sweep_weight_factor'] = random.random()*5
			if gene_num == 4:
				ind['genome']['behavioral'][4]['distance_weight_factor'] = random.random()*5
			if gene_num == 5:
				ind['genome']['behavioral'][5]['wall_distance'] = random.random()*10
				
	return population


def format_print(ind):
	print(ind['id'])
	for gene in ind['genome']['behavioral']:
		print(gene)
	return
	

#Not finished
def convert_genome_to_binary(ind):
	print('Entering binary conversion')
	format_print(ind)
	
	chromosome = 0
	for gene in ind['genome']['behavioral']:
		#print(gene.keys())
		#print(gene.values())
		print('gene: {} \t value:{} \t binary:{}'.format(gene.keys(),gene.values(),bin(gene.values()[0])[2:]))
	
	return
		
	
