import errno

mylines = []

with open('chrMchr1-1.fasta.eg', 'rt') as a:
	with open('chrMchr1-2.fasta.eg', 'rt') as b:
		for a_line in zip(a, b):
			mylines.append(a_line)
print(mylines, end='')

