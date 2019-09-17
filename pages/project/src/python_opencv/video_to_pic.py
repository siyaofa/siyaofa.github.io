
# 视频分解图片
# 1 load 2 info 3 parse 4 imshow imwrite
import cv2

video_files=["VID_20190917_224737.mp4","VID_20190917_223228.mp4","VID_20190917_230057.mp4"]

i = 0

def cvt(video_name):
	global i
	cap = cv2.VideoCapture(video_name)# 获取一个视频打开cap 1 file name
	isOpened = cap.isOpened# 判断是否打开‘
	print(isOpened)
	fps = cap.get(cv2.CAP_PROP_FPS)#帧率
	width = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))#w h
	height = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))
	print(fps,width,height)
	while(isOpened):
		(flag,frame) = cap.read()# 读取每一张 flag frame 
		fileName = 'neg/'+str(i)+'.jpg'
		if flag == True:
			i = i+1
			cv2.imwrite(fileName,frame,[cv2.IMWRITE_JPEG_QUALITY,100])
			print(fileName)
		else:
			break;
	print('end!')

for filename in video_files:
	cvt(filename)
