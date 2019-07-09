import errno

mylines = []

with open('chrMchr1-1.fasta.eg', 'r') as myfile:
	for a_line in myfile:
		mylines.append(a_line.rstrip('\n'))
		if a_line == '>2 chr1:1-X\n':
			break

with open('chrMchr1_1_ONLY.fasta.eg', 'w') as writer:
	#for a in writer('chrMchr1-1.fasta.eg'):
	writer.writelines(mylines)
	print(*mylines, sep = "\n")

	# line = myfile.readline
	# while line != '':
	# 	print(line, end='')
	# 	line = myfile.readline()

mylines1 = []

with open('chrMchr1-2.fasta.eg', 'r') as myfile:
	for a_line in myfile:
		mylines1.append(a_line.rstrip('\n'))
		if a_line == '>2 chr1:1-X\n':
			break

with open('chrMchr1_2_ONLY.fasta.eg', 'w') as writer:
	#for a in writer('chrMchr1-1.fasta.eg'):
	writer.writelines(mylines1)
	print(*mylines1)

#print(mylines, end='')         


# new_path = '/Users/marcelo/Documents/deena_project/mitolin/data/gen/nguyen_nc_2018/20190613-fastas/pinga.fasta.eg'
# new_file = open(new_path, 'w')
# new_file.writelines(myfile)