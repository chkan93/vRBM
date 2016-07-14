def parse_filename(x):
	d = {}
	# print x
	for k in x:
		s1,s2=k.split('-')
		d[s1] = s2
	return d

def parseKey(key):
	d = {}
	ks = key.split('_')
	for k in ks:
		s1,s2 = k.split('-')
		d[s1] = s2
	return d