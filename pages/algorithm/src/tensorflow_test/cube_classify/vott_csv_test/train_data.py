# -*- encoding=utf-8 -*-
import os
import csv
import random

def parse_csv(csv_filename):
    '''
    解析csv文件
    '''
    images=[]
    outputs=[]
    labels=[]
    line_num=0
    with open(os.path.join(csv_filename), newline='') as f:
        reader = csv.reader(f, delimiter=',',quotechar='"' )
        for row in reader:
            image,xmin,ymin,xmax,ymax,label=row
            if(line_num>0) :
                images.append(image)
                output=[float(xmin),float(ymin),float(xmax),float(ymax)]
                outputs.append(output)
                labels.append(label)
            line_num+=1
    # shuffle
    total=len(images)
    random_slice=random.sample(range(total),total)
    print(random_slice)
    shuffle_images=[]
    shuffle_outputs=[]
    shuffle_labels=[]
    for i in range(total):
        shuffle_images.append(images[random_slice[i]])
        shuffle_outputs.append(outputs[random_slice[i]])
        shuffle_labels.append(labels[random_slice[i]])
    return shuffle_images,shuffle_outputs,shuffle_labels

def get_image_path_and_output(data_path,csv_filename):
    '''
    载入所有图像的绝对路径和模型的输出
    '''
    images,outputs,labels=parse_csv(os.path.join(data_path,csv_filename))
    width=480.0
    height=640.0
    for i in range(len(images)):
        images[i]=os.path.join(data_path,images[i])
        [xmin,ymin,xmax,ymax]=outputs[i]
        outputs[i]=[float(xmin)/width,float(ymin)/height,float(xmax)/width,float(ymax)/height]
    total=len(images)
    #random_slice=random.sample(range(total),total)
    
    #images=images[random_slice]
    train_num=int(0.8*total)
    train_images=images[0:train_num]
    train_outputs=outputs[0:train_num]
    test_images=images[train_num:-10]
    test_outputs=outputs[train_num:-10]
    print('train num ',len(train_images),'test num ',len(test_images))
    return train_images,train_outputs,test_images,test_outputs

def get_image_ture_value(image_name,data_path,csv_filename):
    with open(os.path.join(data_path,csv_filename), newline='') as f:
        reader = csv.reader(f, delimiter=',',quotechar='"' )
        for row in reader:
            image,xmin,ymin,xmax,ymax,label=row
            if(image_name==image):
                return (float(xmin),float(ymin),float(xmax),float(ymax))