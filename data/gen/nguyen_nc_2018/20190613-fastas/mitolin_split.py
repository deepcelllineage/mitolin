import errno
import glob

files = glob.glob('*.fasta.eg')
x = 1

for file in files:
	with open(file, 'r') as myfile:
		mylines = []
		for a_line in myfile:
			if a_line == '>2 chr1:1-X\n':
				break
			mylines.append(a_line.rstrip('\n')) 

	with open("chrMchr1New-"+str(x)+".fasta.eg", 'w') as writer:
 		writer.writelines("%s\n" % i for i in mylines)
 		x += 1
