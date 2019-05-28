```python
#coding=gbk
import os
from os import path
def WalkAll(rootDir,total_linenum):
	total_linenum=0
	for root,dirs,files in os.walk(rootDir):
		for file in files:
			name,ext=os.path.splitext(file)
			if(ext==".cpp" or ext==".h" or ext==".c"):
				myfile=open(os.path.join(root,file))
				current_linenum=len(myfile.readlines())
				total_linenum=total_linenum+current_linenum
				print(os.path.join(root,file))
				print("total lines are "+str(total_linenum))
		for dir in dirs:
			WalkAll(dir,total_linenum)
	return total_linenum
#
#
inDir=path.dirname(__file__)
total_linenum=0
total_linenum=WalkAll(inDir,total_linenum)
print("total lines are "+str(total_linenum))
input('wait to exist')
```