import cv2
import numpy as np
import time
face_cascade = cv2.CascadeClassifier("cascade_stage_5_201909182130.xml")
cap=cv2.VideoCapture(0)
  
while True:
	[ret,img]=cap.read()
	gray=cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
	faces = face_cascade.detectMultiScale(gray, scaleFactor=1.1, minNeighbors=4 )
	#faces = face_cascade.detectMultiScale(gray,1.1,5)
	if len(faces)>0:
		for faceRect in faces:
			[x,y,w,h] = faceRect
			if(w>20) and (h>20):
				cv2.rectangle(img,(x,y),(x+w,y+h),(255,0,0),2)
				roi_gray = gray[y:y+h//2,x:x+w]
				roi_color = img[y:y+h//2,x:x+w]	
		if cv2.waitKey(1) & 0xFF == ord('q'):
			break
	cv2.imshow("img",img)
