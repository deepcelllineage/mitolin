title = "days of week\n"
path = '/Users/marcelo/Documents/deena_project/days.txt'
days_file = open(path, 'r')
days = days_file.read()
new_path = 'Users/marcelo/Documents/deena_project/new_days.txt'
new_days = open(new_path, 'w')
new_days.write(title)
print(title)
new_days.write(days)
print(days)
