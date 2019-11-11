#!/usr/bin/env python
import numpy as np
import os
import time

import tensorflow as tf
import tensorflow.keras as keras
import tensorflow.keras.applications as kapp
from tensorflow.keras.datasets import cifar10

(x_train, y_train_cats), (x_test, y_test_cats) = cifar10.load_data()
batch_size = 8
x_train = x_train[:batch_size]
x_train = np.repeat(np.repeat(x_train, 7, axis=1), 7, axis=2)
model = kapp.VGG19()
model.compile(optimizer='sgd', loss='categorical_crossentropy',
              metrics=['accuracy'])

print("Running initial batch (compiling tile program)")
y = model.predict(x=tf.cast(x_train, tf.float32), batch_size=batch_size)

# Now start the clock and run 10 batches
print("Timing inference...")
start = time.time()
for i in range(10):
    y = model.predict(x=tf.cast(x_train, tf.float32), batch_size=batch_size)
print("Ran in {} seconds".format(time.time() - start))