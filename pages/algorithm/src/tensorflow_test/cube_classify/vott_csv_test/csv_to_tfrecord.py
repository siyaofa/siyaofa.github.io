import pandas as pd
import tensorflow as tf
import os
import cv2 as cv


def create_tf_example(filename,encoded,features, label):
    img=cv.imread(filename)
    # print(img.shape)
    height=img.shape[0]
    width=img.shape[1]
    xmins = [features[0] / width]
    
    ymins = [features[1] / height]
    xmaxs = [features[2] / width]
    ymaxs = [features[2]/ height]
    tf_example = tf.train.Example(features=tf.train.Features(feature={
        'image/width':tf.train.Feature(int64_list=tf.train.Int64List(value=[width])),
        'image/height':tf.train.Feature(int64_list=tf.train.Int64List(value=[height])),
        'image/filename':tf.train.Feature(bytes_list=tf.train.BytesList(value=[filename.encode('utf-8')])),
        'image/encoded':tf.train.Feature(bytes_list=tf.train.BytesList(value=[filename.encode('utf-8')])),
        'image/object/bbox/xmin':tf.train.Feature(float_list=tf.train.FloatList(value=xmins)),
        'image/object/bbox/ymin':tf.train.Feature(float_list=tf.train.FloatList(value=ymins)),
        'image/object/bbox/xmax':tf.train.Feature(float_list=tf.train.FloatList(value=xmaxs)),
        'image/object/bbox/ymax':tf.train.Feature(float_list=tf.train.FloatList(value=ymaxs)),
        'image/object/class/text':tf.train.Feature(bytes_list=tf.train.BytesList(value=[label.encode('utf-8')])),
        'image/object/class/label':tf.train.Feature(int64_list=tf.train.Int64List(value=[0])),
    }))
    return tf_example


image_path=r'D:\TEMP\cube_classify\raw_from_user\vott\vott-csv-export'
csv_filename=r'cube4points-export.csv'
csv = pd.read_csv(os.path.join(image_path,csv_filename)).values

with tf.io.TFRecordWriter("csv.tfrecords") as writer:
    line_num=0
    for row in csv:
        line_num+=1
        if(line_num>1) and (line_num<=10) :
            image, features, label = row[0],row[1:-1], row[-1]
            #print(image, features, label)
            example = create_tf_example(filename=os.path.join(image_path,image),encoded='PNG',features=features, label=label)
            writer.write(example.SerializeToString())
        elif line_num>10:
            break