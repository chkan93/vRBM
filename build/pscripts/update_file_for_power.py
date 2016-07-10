from __future__ import print_function
import sys
from fileinput import FileInput
import KEY





def update(adder, adder_path, report_path):
	adder = 'iadder_B16_{0}.v'.format(adder)
	f = FileInput('./pscripts/auto_power.tcl', inplace=True)
	for line in f:
		if KEY.ANALYZE_IADDER in line:
			print('analyze -f verilog ../{0}   ;# {1}\n'.format(adder, KEY.ANALYZE_IADDER), end='')
		elif KEY.IADDER_FOLDER in line:
			print('set saiffiles [glob {0}/*.saif] ;# {1}\n'.format(adder_path, KEY.IADDER_FOLDER), end='')
		elif KEY.REPORT_POWER in line:
			print("report_power > {0}/$fbasename.txt ; # {1}\n".format(report_path, KEY.REPORT_POWER),end='')
		else:
			print(line, end='')
	f.close()


if __name__ == "__main__":
	update(sys.argv[1], sys.argv[2], sys.argv[3])