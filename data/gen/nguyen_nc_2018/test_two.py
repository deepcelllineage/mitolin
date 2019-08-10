
import errno
path = '/Users/marcelo/Documents/deena_project/mitolin/data/gen/nguyen_nc_2018/20190613-fastas'
files = glob.glob(path)
for name in files:
    try:
        with open(name) as f:
            pass # do what you want
    except IOError as exc:
        if exc.errno != errno.EISDIR:
            raise