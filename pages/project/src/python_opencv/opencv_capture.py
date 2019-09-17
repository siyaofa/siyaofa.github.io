#导入opencv模块
import cv2
#捕捉帧，笔记本摄像头设置为0即可
capture = cv2.VideoCapture(0)
#循环显示帧
while(True):
	ret, frame = capture.read()
	#显示窗口第一个参数是窗口名，第二个参数是内容
	cv2.imshow('frame', frame)
	if cv2.waitKey(1) == ord('q'):#按Q退出
		break