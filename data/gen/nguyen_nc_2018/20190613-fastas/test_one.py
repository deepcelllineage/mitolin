import errno

mylines = []

with open('chrMchr1-1.fasta.eg', 'r') as myfile:
	for a_line in myfile:
		if a_line == '>2 chr1:1-X\n':
			break
		mylines.append(a_line.rstrip('\n')) 

with open('chrMchr1_1_ONLY.fasta.eg', 'w') as writer:
	writer.writelines("%s\n" % i for i in mylines)

mylines = []

with open('chrMchr1-2.fasta.eg', 'r') as myfile:
	for a_line in myfile:
		if a_line == '>2 chr1:1-X\n':
			break
		mylines.append(a_line.rstrip('\n'))

with open('chrMchr1_2_ONLY.fasta.eg', 'w') as writer:
	writer.writelines("%s\n" % i for i in mylines)
	