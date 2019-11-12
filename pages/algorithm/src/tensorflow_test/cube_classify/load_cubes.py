from tensorflow.keras.preprocessing.image import ImageDataGenerator

def get_generator(image_size, train_dir, validation_dir):

    train_datagen = ImageDataGenerator(rescale=1./255)
    test_datagen = ImageDataGenerator(rescale=1./255)

    train_generator = train_datagen.flow_from_directory(
        train_dir,
        target_size=image_size,
        batch_size=780,
        class_mode='categorical')

    validation_generator = test_datagen.flow_from_directory(
        validation_dir,
        target_size=image_size,
        batch_size=300,
        class_mode='categorical')

    return train_generator, validation_generator
