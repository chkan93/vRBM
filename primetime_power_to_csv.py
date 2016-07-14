import csv
import sys
import util
from collections import defaultdict

SHEADER = ['Iteration', 'Adder', 'Approximate_Adder_Num', 'Criticality_ID','Slack', 'Total_Power', 'Combinational_Power']

def rd(x,n):
	return ("{:."+ str(n) +"f}").format(x)

def toCSV(in_file, out_file, norm):
	writer = csv.writer(outfile, delimiter=',')
	writer.writerow(SHEADER)
	nwriter = csv.writer(norm, delimiter=',')
	nwriter.writerow(SHEADER)
	d = defaultdict(lambda:defaultdict(float))
	for line in in_file:
		line = line.split(' ')
		p = line[2][0:-5]
		# print(p)
		try:
			params = util.parse_filename(p.split(','))
		except:
			pass

		slack = float(line[3])
		total_power = float(line[4])
		com_power = float(line[5])
		key = "adder-{0}_iter-{1}_cid-{2}_cnum-{3}".format(params['adder'], 
				params['iteration'],params['cid'], params['cnum'])
		d[key]['num'] += 1
		d[key]['comP'] += com_power
		d[key]['total'] += total_power
		d[key]['slack'] += slack

	max_total = -1000
	max_com = -1000
	for k in d.keys():
		tt = d[k]['total']/d[k]['num']
		tc = d[k]['comP']/d[k]['num']
		if tt > max_total:
			max_total = tt
		if tc > max_com:
			max_com = tc

	for k,v in d.iteritems():
		i = util.parseKey(k)
		writer.writerow([i['iter'], i['adder'], i['cnum'], i['cid'], rd(v['slack']/v['num'], 6), rd(v['total']/v['num'], 6), rd(v['comP']/v['num'], 6)])
		nwriter.writerow([i['iter'], i['adder'], i['cnum'], i['cid'], rd(v['slack']/v['num'], 6), rd(v['total']/v['num']/max_total*100, 4), rd(v['comP']/v['num']/max_com*100, 4)])


if __name__ == "__main__":
	with open(sys.argv[1], 'r') as infile:
		with open(sys.argv[2], 'w') as outfile:
			with open(sys.argv[2]+'.norm','w') as outfile_short:
				toCSV(infile, outfile, outfile_short)