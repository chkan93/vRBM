import csv
import sys
import util
from collections import defaultdict

def parseKey(key):
	d = {}
	ks = key.split('_')
	for k in ks:
		s1,s2 = k.split('-')
		d[s1] = s2
	return d

HEADER = ['Iteration', 'Adder', 'Approximate_Adder_Num', 'Criticality_ID', 'Image_ID','Register_Power', 'Combinational_Power', 'Total_Power']
SHEADER = ['Iteration', 'Adder', 'Approximate_Adder_Num', 'Criticality_ID','Register_Power', 'Combinational_Power', 'Total_Power']
def toCSV(in_file, out_file, short):
	writer = csv.writer(outfile, delimiter=',')
	writer.writerow(HEADER)
	swriter = csv.writer(short, delimiter=',')
	swriter.writerow(SHEADER)
	d = defaultdict(lambda:defaultdict(float))
	for line in in_file:
		line = line.split(',')
		params = util.parse_filename(line[:5])
		regP = float(line[5].split(' ')[1])
		comP = float(line[6].split(' ')[1])
		total = float(line[-1])
		#sum 
		key = "adder-{0}_iter-{1}_cid-{2}_cnum-{3}".format(params['adder'], 
				params['iteration'],params['cid'], params['cnum'])
		d[key]['num'] += 1
		d[key]['regP'] += regP
		d[key]['comP'] += comP
		d[key]['total'] += float(line[-1])
		writer.writerow([
			params['iteration'],
			params['adder'], 
			params['cnum'],
			params['cid'], 
			params['image'],
			regP,
			comP,
			total
			])
	for k,v in d.iteritems():
		i = parseKey(k)
		swriter.writerow([i['iter'], i['adder'], i['cnum'], i['cid'], v['regP']/v['num'],v['comP']/v['num'], v['total']/v['num']])


if __name__ == "__main__":
	with open(sys.argv[1], 'r') as infile:
		with open(sys.argv[2], 'w') as outfile:
			with open(sys.argv[2]+'.short','w') as outfile_short:
				toCSV(infile, outfile, outfile_short)