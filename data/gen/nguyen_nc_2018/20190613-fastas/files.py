title = "days of week\n"
path = '/Users/marcelo/Documents/deena_project/mitolin/data/gen/nguyen_nc_2018/20190613-fastas/days.txt'
days_file = open(path, 'r')
days = days_file.read()
new_path = '/Users/marcelo/Documents/deena_project/mitolin/data/gen/nguyen_nc_2018/20190613-fastas/new_days.txt'
new_days = open(new_path, 'w')
new_days.write(title)
print(title)
new_days.write(days)
print(days)
