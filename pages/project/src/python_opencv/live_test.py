#导入opencv模块
import cv2 as cv
#捕捉帧，笔记本摄像头设置为0即可
capture = cv.VideoCapture(0)


def angle_cos(p0, p1, p2):
	d1, d2 = (p0-p1).astype('float'), (p2-p1).astype('float')
	return abs( np.dot(d1, d2) / np.sqrt( np.dot(d1, d1)*np.dot(d2, d2) ) )

def find_squares(img):
	img = cv.GaussianBlur(img, (5, 5), 0)
	squares = []
	for gray in cv.split(img):
		for thrs in range(0, 255, 26):
			if thrs == 0:
				bin = cv.Canny(gray, 0, 50, apertureSize=5)
				bin = cv.dilate(bin, None)
			else:
				_retval, bin = cv.threshold(gray, thrs, 255, cv.THRESH_BINARY)
			bin, contours, _hierarchy = cv.findContours(bin, cv.RETR_LIST, cv.CHAIN_APPROX_SIMPLE)
			for cnt in contours:
				cnt_len = cv.arcLength(cnt, True)
				cnt = cv.approxPolyDP(cnt, 0.02*cnt_len, True)
				if len(cnt) == 4 and cv.contourArea(cnt) > 1000 and cv.isContourConvex(cnt):
					cnt = cnt.reshape(-1, 2)
					max_cos = np.max([angle_cos( cnt[i], cnt[(i+1) % 4], cnt[(i+2) % 4] ) for i in xrange(4)])
					if max_cos < 0.1:
						squares.append(cnt)
	return squares


def process(img):
	gray=cv.cvtColor(img,cv.COLOR_BGR2GRAY)
	
	hsv=cv.cvtColor(img,cv.COLOR_BGR2HSV)
	hue=hsv[:,:,0]
	
	dxdy=40
	edges = cv.Canny(hue,dxdy,dxdy)
	
	return edges

#循环显示帧
while(True):
	ret, frame = capture.read()
	squares = find_squares(frame)
	cv.drawContours( frame, squares, -1, (0, 255, 0), 3 )
	#显示窗口第一个参数是窗口名，第二个参数是内容
	cv.imshow('frame',frame )
	if cv.waitKey(1) == ord('q'):#按Q退出
		break