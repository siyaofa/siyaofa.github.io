import os
import shutil
from PIL import Image
path = r'cube_picture_with_background'

targe_size=(480,640)

dst_path='raw_%dx%d'%(targe_size[0],targe_size[1])

if not os.path.exists(dst_path):
	os.makedirs(dst_path)
print(dst_path)

num=0

for root, dirs, files in os.walk(path):
	for file in files:
		file_path=os.path.join(root,file)
		img = Image.open(file_path)
		width_height_scale_ratio=abs(img.size[0]/img.size[1]-targe_size[0]/targe_size[1])
		print(num,file_path,img.size,width_height_scale_ratio)
		dst_file_path=os.path.join(dst_path,file)
		if img.size==targe_size:
			num+=1
			shutil.copyfile(file_path,dst_file_path)
		elif (width_height_scale_ratio<0.01):
			img.thumbnail(targe_size)
			img.save(dst_file_path)
			num+=1