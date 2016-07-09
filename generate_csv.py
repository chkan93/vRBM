import csv
import sys
import util

HEADER = ['Iteration', 'Adder', 'Approximate_Adder_Num', 'Criticality_ID', 'Image_ID','Register_Power', 'Combinational_Power', 'Total_Power']

def toCSV(in_file, out_file):
	writer = csv.writer(outfile, delimiter=',')
	writer.writerow(HEADER)

	for line in in_file:
		line = line.split(',')
		params = util.parse_filename(line[:5])
		regP = float(line[5].split(' ')[1])
		comP = float(line[6].split(' ')[1])
		total = float(line[-1])
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


if __name__ == "__main__":
	with open(sys.argv[1], 'r') as infile:
		with open(sys.argv[2], 'w') as outfile:
			toCSV(infile, outfile)