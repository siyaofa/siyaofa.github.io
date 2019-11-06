import tensorflow as tf
import datetime


need_train = True


mnist = tf.keras.datasets.mnist

(x_train, y_train), (x_test, y_test) = mnist.load_data()
x_train, x_test = x_train / 255.0, x_test / 255.0


if need_train:
    model = tf.keras.models.Sequential([
        tf.keras.layers.Flatten(input_shape=(28, 28)),
        tf.keras.layers.Dense(512, activation=tf.nn.relu),
        tf.keras.layers.Dropout(0.2),
        tf.keras.layers.Dense(10, activation=tf.nn.softmax)
    ])
    model.compile(optimizer='adam',
                  loss='sparse_categorical_crossentropy',
                  metrics=['accuracy'])

    log_dir = "logs/fit/"+datetime.datetime.now().strftime("%Y%m%d.%H%M%S")

    #tensorboard_callback = tf.keras.callbacks.TensorBoard(log_dir=log_dir, histogram_freq=1)

    #tf.keras.models.save_model(model, "untrained")
    model.fit(x=x_train,
              y=y_train,
              epochs=5,
              validation_data=(x_test, y_test),
              use_multiprocessing=True)
    # callbacks=[tensorboard_callback])

    tf.keras.models.save_model(model, "trained")
    """ writer = tf.summary.create_file_writer(log_dir)
    with writer.as_default():
        for step in range(100):
            tf.summary.scalar("my_metric", 0.5, step=step)
            writer.flush() """
else:
    model = tf.keras.models.load_model("trained")


score=model.evaluate(x_test, y_test,verbose=0)

print(score)