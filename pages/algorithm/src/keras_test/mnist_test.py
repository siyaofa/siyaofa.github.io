#!/usr/bin/env python
import numpy as np
import os
import time

#os.environ["KERAS_BACKEND"] = "plaidml.keras.backend"

import tensorflow.keras as keras
import datetime

start = time.time()

mnist = keras.datasets.mnist

(x_train, y_train), (x_test, y_test) = mnist.load_data()
x_train, x_test = x_train / 255.0, x_test / 255.0



model =  keras.models.Sequential([
keras.layers.Flatten(input_shape=(28, 28)),
keras.layers.Dense(512, activation='relu'),
keras.layers.Dropout(0.2),
keras.layers.Dense(10, activation='softmax')
])
model.compile(optimizer='adam',
loss='sparse_categorical_crossentropy',
metrics=['accuracy'])

model.fit(x=x_train,
y=y_train,
epochs=5,
validation_data=(x_test, y_test) )

#keras.models.save_model(model, "trained")

score=model.evaluate(x_test, y_test,verbose=0)

print(score)

print("Ran in {} seconds".format(time.time() - start))