---
layout: page
title: tensorflow 2.0 练习
date:   2019-11-06
---

## 安装CPU版tensorflow 2.0

`pip install tensorflow`

2.0和1.x版本API接口变化较大

## 测试

### MNIST 示例

网上很多例子都是1.x的，导致花了很多时间找[demo](https://cloud.tencent.com/developer/article/1519704)

```python
import tensorflow as tf

mnist = tf.keras.datasets.mnist

(x_train, y_train),(x_test, y_test) = mnist.load_data()
x_train, x_test = x_train / 255.0, x_test / 255.0

model = tf.keras.models.Sequential([
  tf.keras.layers.Flatten(input_shape=(28, 28)),
  tf.keras.layers.Dense(512, activation=tf.nn.relu),
  tf.keras.layers.Dropout(0.2),
  tf.keras.layers.Dense(10, activation=tf.nn.softmax)
])
model.compile(optimizer='adam',
              loss='sparse_categorical_crossentropy',
              metrics=['accuracy'])

model.fit(x_train, y_train, epochs=5)
model.evaluate(x_test, y_test)
```
终端输出

```
Train on 60000 samples
Epoch 1/5
60000/60000 [==============================] - 10s 175us/sample - loss: 0.2207 - accuracy: 0.9348
Epoch 2/5
60000/60000 [==============================] - 9s 158us/sample - loss: 0.0948 - accuracy: 0.9712
Epoch 3/5
60000/60000 [==============================] - 10s 159us/sample - loss: 0.0684 - accuracy: 0.9782
Epoch 4/5
60000/60000 [==============================] - 9s 156us/sample - loss: 0.0532 - accuracy: 0.9828
Epoch 5/5
60000/60000 [==============================] - 9s 153us/sample - loss: 0.0428 - accuracy: 0.9862

- 1s 73us/sample - loss: 0.0328 - accuracy: 0.9807

```

5次迭代可以到达98%的准确率
