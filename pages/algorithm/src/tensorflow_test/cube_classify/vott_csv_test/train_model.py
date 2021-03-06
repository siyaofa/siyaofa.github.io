# -*- encoding=utf-8 -*-

import csv
import os
import tensorflow as tf
from tensorflow.keras import layers,models
from tensorflow.keras.layers import Conv2D,MaxPooling2D,Flatten,Dense,Dropout,BatchNormalization
from tensorflow.keras.callbacks import ModelCheckpoint

from net import create_model

from train_data import get_image_path_and_output

data_path=r'D:\TEMP\cube_classify\raw_from_user\vott\vott-csv-export'
csv_filename=r'cube4points-export.csv'

def preprocess(x,y):
    # x: 图片的路径List，y：图片的数字编码List
    x = tf.io.read_file(x) # 根据路径读取图片
    x = tf.image.decode_jpeg(x, channels=3) # 图片解码
    x = tf.image.resize(x, [90, 120]) # 图片缩放
    # 数据增强
    # x = tf.image.random_flip_up_down(x)
    # x= tf.image.random_flip_left_right(x) # 左右镜像
    # x = tf.image.random_crop(x, [224, 224, 3]) # 随机裁剪
    # 转换成张量
    # x: [0,255]=> 0~1
    x = tf.cast(x, dtype=tf.float32) / 255.
    # 0~1 => D(0,1)
    # x = normalize(x) # 标准化
    y = tf.convert_to_tensor(y) # 转换成张量
    print(y)
    return x, y





train_images,train_outputs,test_images,test_outputs =get_image_path_and_output(data_path,csv_filename)
batchsz = 32
db_train = tf.data.Dataset.from_tensor_slices((train_images, train_outputs))
db_train = db_train.shuffle(100).map(preprocess).batch(batchsz)

db_val = tf.data.Dataset.from_tensor_slices((test_images, test_outputs))
db_val = db_val.map(preprocess).batch(batchsz)

model=create_model()


early_stopping = tf.keras.callbacks.EarlyStopping(
monitor='val_loss',
min_delta=0.00001,
patience=50
)
# checkpoint
filepath = "weights\weights-improvement-{epoch:02d}-{val_loss:.8f}.hdf5"
#filepath = "weights\weights.hdf5"
# 中途训练效果提升, 则将文件保存, 每提升一次, 保存一次
checkpoint = ModelCheckpoint(filepath, monitor='val_loss', verbose=1, save_best_only=True,
                            mode='min')
callbacks_list = [checkpoint,early_stopping]
history=model.fit(db_train,
validation_data=db_val,
#validation_freq=1,
epochs=500,
callbacks=callbacks_list)

model.save("csv.h5")
# load weights 加载模型权重
# model.load_weights('weights.best.hdf5')

print(history)

mse = history.history['mse']
loss = history.history['loss']
val_loss= history.history['val_loss']
val_mse= history.history['val_mse']
import matplotlib.pyplot as plt

epochs = range(1, len(mse) + 1)
plt.plot(epochs, loss, 'bo', label='Training loss')
plt.plot(epochs, val_loss, 'b', label='validation loss')
plt.title('Training and validation loss')
plt.legend()
# plt.figure()
# plt.plot(epochs, mse, 'bo', label='Training mse')
# plt.plot(epochs, val_mse, 'b', label='validation mse')
# plt.title('Training and validation mse')
# plt.legend()
plt.show()