import numpy as np
import cv2 as cv
from matplotlib import pyplot as plt

img = cv.imread('raw_Front.png')
cv.imshow("img",img)
gray=cv.cvtColor(img,cv.COLOR_BGR2GRAY)
cv.imshow("gray",gray)
edges = cv.Canny(gray,10,10)
cv.imshow("edges",edges)

hsv = cv.cvtColor(img,cv.COLOR_BGR2HSV)
cv.imshow("hsv",hsv)
hue=hsv[:,:,1]
cv.imshow("hue",hue)

cv.waitKey() 
