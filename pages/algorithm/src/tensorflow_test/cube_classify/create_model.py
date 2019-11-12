from tensorflow.keras import layers
from tensorflow.keras import models


def get_model(image_size):
	model = models.Sequential()
	model.add(layers.Conv2D(32, (3, 3), activation='relu',
	input_shape=(image_size[0],image_size[1], 3)))
	model.add(layers.MaxPooling2D((2, 2)))
	model.add(layers.Conv2D(64, (3, 3), activation='relu'))
	model.add(layers.MaxPooling2D((2, 2)))
	model.add(layers.Conv2D(128, (3, 3), activation='relu'))
	model.add(layers.MaxPooling2D((2, 2)))
	model.add(layers.Flatten())
	model.add(layers.Dense(128, activation='relu'))
	model.add(layers.Dense(36, activation='relu'))
	model.add(layers.Dense(3, activation='softmax'))
	#model.add(layers.Dense(3, activation='relu'))
	model.summary()
	model.compile(optimizer='adam',
			loss='binary_crossentropy',
			metrics=['accuracy'])
	return model