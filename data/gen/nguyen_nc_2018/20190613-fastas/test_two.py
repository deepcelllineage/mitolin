import os
file_content = []
path = '/Users/marcelo/Documents/deena_project/mitolin/data/gen/nguyen_nc_2018/20190613-fastas'

for file in os.listdir(path):
	#print(i)
	if file.endswith(".eg"):
		with open(os.path.join(path, file), "r") as fd:
			file_content.append(fd.read)
		print(file)

