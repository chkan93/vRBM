from __future__ import print_function 
from collections import defaultdict
import util
import sys

def process(in_path, out_path):
	d = defaultdict(lambda:defaultdict(float))
	with open(in_path, 'r') as inf:
		for line in inf:
			data = line.split(',')
			params = util.parse_filename(data[:5])
			key = "adder-{0}_iter-{1}_cid-{2}_cnum-{3}".format(params['adder'], 
				params['iteration'],params['cid'], params['cnum'])
			d[key]['num'] += 1
			d[key]['power'] += float(data[-1])


	with open(out_path, 'w') as of:
		for k,v in d.iteritems():
			print("{0},{1},{2},{3}".format(k,v['power'],v['num'],v['power']/v['num']), file=of)














if __name__ == "__main__":
	process(sys.argv[1], sys.argv[2])