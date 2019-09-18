import cv2
import os
import sys
from process_bar import process_bar
# 视频分解图片
# 1 load 2 info 3 parse 4 imshow imwrite



video_path=r'D:/迅雷下载/pornhub'
pic_path="picture"
interval=30 #时间间隔 s
generated_picture_number=0
max_picture_count=5000
finished=False



def create_if_not_exist(dir):
	isExist=os.path.exists(dir)
	if not isExist:
		os.makedirs(dir)
		print("creat "+dir)
		

	
	
def cvt(video_name,interval):
	global generated_picture_number
	global max_picture_count
	global pic_path 
	global finished
	#print(video_name,interval)
	frame_index=0

	create_if_not_exist(pic_path)
	cap = cv2.VideoCapture(video_name)# 获取一个视频
	isOpened = cap.isOpened# 判断是否打开
	fps = cap.get(cv2.CAP_PROP_FPS)#帧率
	frame_step=int(interval*fps)
	width = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))#w h
	height = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))
	
	frame_count=int(fps*cap.get(cv2.CAP_PROP_FRAME_COUNT))
	#print(fps,frame_step,width,height,frame_count/frame_step)
	while(isOpened):
		if(generated_picture_number>max_picture_count):
			finished=True
			break
		frame_index+=frame_step
		cap.set(cv2.CAP_PROP_POS_FRAMES,frame_index)  #设置要获取的帧号
		process_bar(generated_picture_number,max_picture_count)
		(flag,frame) = cap.read()# 读取
		fileName = pic_path+'/'+str(generated_picture_number)+'.jpg'
		if flag == True:
			cv2.imwrite(fileName,frame)
			generated_picture_number+=1
			#print(fileName)
		else:
			break;
	print('end!')



def video_to_picture(src_path,dst_path,time_interval,count):
	print(src_path,dst_path,time_interval,count)
	global video_path 
	global pic_path 
	global interval 
	global max_picture_count 
	video_path=src_path
	pic_path=dst_path
	interval=time_interval
	max_picture_count=count
	for filename in os.listdir(video_path):
		if finished:
			break;
		cvt(video_path+"/"+filename,interval)
