import matplotlib.pyplot as plt
import time

from create_model import get_model
from load_cubes import get_generator
'''
从路径中训练模型
'''
train_dir = r'D:\TEMP\cube_classify\raw_from_user\train_test_1\train'
validation_dir = r'D:\TEMP\cube_classify\raw_from_user\train_test_1\test'

image_size = (80, 60)
class_num=6

train_generator, validation_generator = get_generator(
    image_size, train_dir, validation_dir)

model = get_model(image_size,class_num)

time_str=time.strftime("%Y%m%d_%H%M%S", time.localtime()) 
print(time_str)
input_size='%dx%d'%(image_size[0],image_size[1])
model_name=f'models/{time_str}_cubes_3rd_class_{class_num}_input_{input_size}.h5'
model.save(model_name)

history = model.fit_generator(
    train_generator,
    epochs=5,
    validation_data=validation_generator,
    shuffle=True)

model.save(model_name)

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
