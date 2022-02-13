import re
import json
import pandas as pd
with open('test.txt') as f:
	patterns=["step:", "Command being timed:",			"User time (seconds):",	"System time (seconds):","Percent of CPU this job got:","Elapsed (wall clock) time (h:mm:ss or m:ss):","Average shared text size (kbytes):","Average unshared data size (kbytes):","Average stack size (kbytes):","Average total size (kbytes):","Maximum resident set size (kbytes):","Average resident set size (kbytes):","Major (requiring I/O) page faults:","Minor (reclaiming a frame) page faults:","Voluntary context switches:","Involuntary context switches:","Swaps:","File system inputs:","File system outputs:","Socket messages sent:","Socket messages received:","Signals delivered:","Page size (bytes):","Exit status:"]
# ((\w|\s)+|(\(.+\)))+
	pattern="(.+):(.+)"
	pattern="\\s*(\\D+)\\s*:\\s*((\\d|\\(||\\)|\\.|:)+)\\s*"
	pattern='\\s*(?P<key>\\D+)\\s*:\\s*(?P<vs>(".+")|(?P<v>:|\\d)+)\\s*'
	prog = re.compile(pattern)
	dict={}
	jsons=[]
	lines = f.readlines()
	for l in lines:
    	
		l=re.sub(r'(\s\s)+', '', l)
		l=re.sub('\n','',l)
		l=re.sub('\t',' ',l)
		if l=='':
			jsons.append(dict)
			dict={}
		result = prog.match(l)
		if result is not None:
			s=result.group(1)
			e=result.group(2)
			dict[s]=e
			
	jsons.append(dict)
	doc=json.loads(json.dumps(jsons))
	#print(doc)
	dataframe = pd.DataFrame.from_dict(doc)
	pd.set_option('display.max_columns', None)
	dataframe.to_csv('f.csv')
	##print(dataframe)
