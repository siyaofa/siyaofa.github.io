from tensorflow.keras import models
import os
#model.save('cubes_3rd_5_class.h5')
from PIL import Image
import numpy as np
import cv2 as cv
import shutil

#input_path=r'D:\TEMP\cube_classify\raw_from_user\predict\input'
#input_path=r'D:\TEMP\cube_classify\raw_from_user\raw_480x640'
input_path=r'D:\TEMP\cube_classify\cubes\predict'
output_path=os.path.join(input_path,'output')
image_size = (60, 80)
model = models.load_model(r'models\cubes_3rd_6_class.h5')

def copy_to_label_dir(label,file_path):
	'''
	根据标签把文件保存至
	'''
	(root,filename) = os.path.split(file_path)
	dst_path=output_path+'\\'+str(label)
	if not os.path.exists(dst_path):
		os.makedirs(dst_path)
	dst_file_path=dst_path+'\\'+filename
	shutil.copyfile(file_path,dst_file_path)

def predict_image_label(model,file_path):
	'''
	预测标签
	'''
	img = cv.imread(file_path)
	img=cv.resize(img,image_size)
	img = img.reshape((1,img.shape[0],img.shape[1],img.shape[2]))
	#cv.imshow('img',img[0])
	#cv.waitKey()
	x=img/255.0
	y=model.predict(x)[0]
	label=np.where(y==np.max(y))[0][0]
	print(label,file_path)
	copy_to_label_dir(label,file_path)
	return label

dirs = os.listdir( input_path )
index=0
# 输出所有文件和文件夹
for file in dirs:
	file_path=os.path.join(input_path,file)
	index+=1
	if (index%5==1):
		predict_image_label(model,file_path)
	

#model.predict(x)