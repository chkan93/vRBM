def parse_filename(x):
	d = {}
	# print x
	for k in x:
		s1,s2=k.split('-')
		d[s1] = s2
	return d