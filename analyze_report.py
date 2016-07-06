from __future__  import print_function
from collections import defaultdict
import sys


KEYS = [
	'register',
	'combinational'
]

def tostr(d):
	## Internal, Switching, Leakage
	r = ""
	t = "{0} {1} {2}"
	for k in KEYS:
		r += (t.format(d[k]['i'], d[k]['s'], d[k]['l'])) 
		r += ","
	return r

def analyze(file_path):
	with open(file_path, 'r') as f:
		s = f.read()
		d = defaultdict(dict)
		prev_idx = 0
		total = 0.0
		for k in KEYS:
			start_idx = s.find(k, prev_idx)
			prev_idx = s.find('\n', start_idx)
			data = filter(lambda x: x!='', s[start_idx:prev_idx].split(" "))
			total = total + float(data[1]) + float(data[2]) + float(data[3])
			d[k]['i'], d[k]['s'], d[k]['l'] = float(data[1]), float(data[2]), float(data[3])


		return tostr(d)+"{0}".format(total)











if __name__ == "__main__":
	print(analyze(sys.argv[1]))


