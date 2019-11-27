# -*- encoding=utf-8 -*-
import os
import csv

def get_image_path_and_output(data_path,csv_filename):
    '''
    载入所有图像的绝对路径和模型的输出
    '''
    images=[]
    outputs=[]
    labels=[]
    line_num=0
    width=480.0
    height=640.0
    with open(os.path.join(data_path,csv_filename), newline='') as f:
        reader = csv.reader(f, delimiter=',',quotechar='"' )
        for row in reader:
            image,xmin,ymin,xmax,ymax,label=row
            if(line_num>0) :
                images.append(os.path.join(data_path,image))
                output=[float(xmin)/width,float(ymin)/height,float(xmax)/width,float(ymax)/height]
                #print(image,output)
                outputs.append(output)
                labels.append(label)
            line_num+=1
    train_images=images[0:200]
    train_outputs=outputs[0:200]
    test_images=images[200:-1]
    test_outputs=outputs[200:-1]
    print(len(train_images),len(test_images))
    return train_images,train_outputs,test_images,test_outputs

def get_image_ture_value(image_name,data_path,csv_filename):
    with open(os.path.join(data_path,csv_filename), newline='') as f:
        reader = csv.reader(f, delimiter=',',quotechar='"' )
        for row in reader:
            image,xmin,ymin,xmax,ymax,label=row
            if(image_name==image):
                return (float(xmin),float(ymin),float(xmax),float(ymax))