import os
import shutil
path = r'D:\TEMP\raw_cubes'

dst_path=r'raw'

index=0

for root, dirs, files in os.walk(path):
	for file in files:
		if 'raw' in file:
			index+=1
			file_path=os.path.join(root,file)
			print(index,file_path)
			dst_file_path=os.path.join(dst_path,str(index)+os.path.splitext(file)[-1])
			shutil.copyfile(file_path,dst_file_path)