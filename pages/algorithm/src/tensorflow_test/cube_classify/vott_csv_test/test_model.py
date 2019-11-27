import tensorflow as tf
from tensorflow.keras import models
import os
from train_data import get_image_ture_value
import cv2 as cv
import math

data_path=r'D:\Github\siyaofa.github.io\pages\algorithm\src\tensorflow_test\cube_classify\vott_csv_test\vott-csv-export'

imagename=r'19199.png'

def calc_predict_error(y,y_pre):
    xmin=y[0]-y_pre[0]
    ymin=y[1]-y_pre[1]
    xmax=y[2]-y_pre[2]
    ymax=y[2]-y_pre[2]
    leftup_err=math.sqrt(xmin**2+ymin**2)
    rightdown_err=math.sqrt(xmax**2+ymax**2)
    print(leftup_err,rightdown_err)

def get_true_and_predict(data_path,imagename):
    x = tf.io.read_file(os.path.join(data_path,imagename)) # 根据路径读取图片
    x = tf.image.decode_jpeg(x, channels=3) # 图片解码
    x = tf.image.resize(x, [90, 120]) # 图片缩放
    x = tf.cast(x, dtype=tf.float32) / 255.
    x = tf.expand_dims(x, axis=0)
    model = models.load_model(r'csv.h5')
    y=model.predict(x)
    width=480.0
    height=640.0
    [xmin,ymin,xmax,ymax]=y[0]
    xmin=int(width*xmin)
    xmax=int(width*xmax)
    ymin=int(height*ymin)
    ymax=int(height*ymax)
    y_pre=(xmin,ymin,xmax,ymax)

    y_true=get_image_ture_value(imagename,data_path,r'cube-export.csv')
    calc_predict_error(y_true,y_pre)
    return y_true,y_pre


def show(image_filename,y_true,y_pre):
    

    img=cv.imread(image_filename)
    (xmin,ymin,xmax,ymax)=y_true
    cv.rectangle(img, (int(xmin),int(ymin) ), (int(xmax), int(ymax)), (0, 255, 0), 2)
    (xmin,ymin,xmax,ymax)=y_pre
    cv.rectangle(img, (int(xmin),int(ymin) ), (int(xmax), int(ymax)), (0, 0, 255), 2)
    cv.imshow('green true red predict',img)
    

y_true,y_pre=get_true_and_predict(data_path,imagename)
print(y_true,y_pre)
show(os.path.join(data_path,imagename),y_true,y_pre)
cv.waitKey()