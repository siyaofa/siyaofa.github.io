import pandas as pd
import tensorflow as tf

def create_tf_example(image,features, label):

    tf_example = tf.train.Example(features=tf.train.Features(feature={
        'image':tf.train.Feature(bytes_list=tf.train.BytesList(value=[image.encode('utf-8')])),
        'xmin':tf.train.Feature(float_list=tf.train.FloatList(value=[features[0]])),
        'ymin':tf.train.Feature(float_list=tf.train.FloatList(value=[features[1]])),
        'xmax':tf.train.Feature(float_list=tf.train.FloatList(value=[features[2]])),
        'ymax':tf.train.Feature(float_list=tf.train.FloatList(value=[features[3]])),
        'label':tf.train.Feature(bytes_list=tf.train.BytesList(value=[label.encode('utf-8')])),
    }))
    return tf_example



csv = pd.read_csv(r"D:\TEMP\cube_classify\raw_from_user\vott\vott-csv-export\cube4points-export.csv").values

with tf.io.TFRecordWriter("csv.tfrecords") as writer:
    line_num=0
    for row in csv:
        line_num+=1
        if(line_num>1) :
            image, features, label = row[0],row[1:-1], row[-1]
            print(image, features, label)
            example = create_tf_example(image,features, label)
            writer.write(example.SerializeToString())