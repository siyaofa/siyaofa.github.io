#!/usr/bin/env python
import numpy as np
import os
import time

import tensorflow as tf
import tensorflow.keras as keras
from tensorflow.keras.datasets import cifar10

(x_train, y_train_cats), (x_test, y_test_cats) = cifar10.load_data()
batch_size = 80
print(x_train.shape,y_train_cats.shape)
x_train = x_train[:batch_size]
print(x_train.shape)
x_train = np.repeat(np.repeat(x_train, 7, axis=1), 7, axis=2)
print(x_train.shape)
x_train=tf.cast(x_train, tf.float32)
model = keras.applications.VGG19()
model.compile(optimizer='sgd', loss='categorical_crossentropy',
	metrics=['accuracy'])
model.summary()
#print("Running initial batch (compiling tile program)")
#y = model.predict(x=x_train, batch_size=batch_size)

# Now start the clock and run 10 batches
print("Timing inference...")
start=time.time()
y = model.predict(x=x_train)
print("Ran in {} seconds".format(time.time() - start))