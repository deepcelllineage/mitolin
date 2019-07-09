

with open('chrMchr1-1.fasta.eg') as f:
	with open('chrMchr1-2.fasta.eg') as g:
		content = f.readlines()
		content = g.readlines()
# you may also want to remove whitespace characters like `\n` at the end of each line
content = [x.strip() for x in content] 
print(content)

# with open('chrMchr1-1.fasta.eg', 'r') as myfile:
# 	for a_line in myfile:
# 		mylines.append(a_line)
# 		if a_line == '>2 chr1:1-X\n':
# 			break