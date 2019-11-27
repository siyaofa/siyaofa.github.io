# -*- encoding=utf-8 -*-

from tensorflow.keras import layers,models
from tensorflow.keras.layers import Conv2D,MaxPooling2D,Flatten,Dense,Dropout,BatchNormalization
from tensorflow.keras import backend as K
import tensorflow as tf

class MyModel( models.Model):
    # 自定义网络类，继承自Model 基类
    def __init__(self):
        super(MyModel, self).__init__()
        # 完成网络内需要的网络层的创建工作
        self.fc1 = Dense(28*28, 256)
        self.fc2 = Dense(256, 128)
        self.fc3 = Dense(128, 64)
        self.fc4 = Dense(64, 32)
        self.fc5 = Dense(32, 10)
    def call(self, inputs, training=None):
        # 自定义前向运算逻辑
        x = self.fc1(inputs)
        x = self.fc2(x)
        x = self.fc3(x)
        x = self.fc4(x)
        x = self.fc5(x)
        return x

 

def create_model():
    model = models.Sequential([
    Conv2D(32, (3, 3), 
        activation='relu',
        input_shape=(90,120, 3)),
    MaxPooling2D((2, 2)),
    Dropout(0.2),
    Conv2D(64, (3, 3), activation='relu'),
    MaxPooling2D((2, 2)),
    Dropout(0.2),
    Conv2D(128, (3, 3), activation='relu'),
    MaxPooling2D((2, 2)),
    Dropout(0.2),
    Conv2D(256, (3, 3), activation='relu'),
    MaxPooling2D((2, 2)),
    Flatten(),
    #BatchNormalization(), # 追加BN 层
    Dropout(0.2),
    Dense(512, activation='relu'),
    Dropout(0.2),
    Dense(128, activation='relu'),
    Dropout(0.2),
    Dense(64, activation='relu'),
    Dropout(0.2),
    Dense(36, activation='relu'),
    Dense(4, activation='relu')
    ])
    model.summary()
    model.compile(loss='mean_squared_error', optimizer='adam', metrics=['mse'])
    # model.compile(loss= Position_Loss , optimizer='adam', metrics=['mse'])
    return model

# create_model()