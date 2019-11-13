import matplotlib.pyplot as plt


from create_model import get_model
from load_cubes import get_generator

train_dir = r'C:\Users\siyao\.keras\datasets\cube_classify\cubes\train'
validation_dir = r'C:\Users\siyao\.keras\datasets\cube_classify\cubes\test'

image_size = (60, 80)

train_generator, validation_generator = get_generator(
    image_size, train_dir, validation_dir)

model = get_model(image_size)


history = model.fit_generator(
    train_generator,
    epochs=60,
    validation_data=validation_generator,
    shuffle=True)

model.save('cubes_3rd_3_class.h5')

print(history.history)

acc = history.history['accuracy']
val_acc = history.history['val_accuracy']
loss = history.history['loss']
val_loss = history.history['val_loss']
epochs = range(1, len(acc) + 1)
plt.plot(epochs, acc, 'bo', label='Training acc')
plt.plot(epochs, val_acc, 'b', label='Validation acc')
plt.title('Training and validation accuracy')
plt.legend()
plt.figure()
plt.plot(epochs, loss, 'bo', label='Training loss')
plt.plot(epochs, val_loss, 'b', label='Validation loss')
plt.title('Training and validation loss')
plt.legend()
plt.show()
