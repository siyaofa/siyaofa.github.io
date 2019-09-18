---
layout: page
title: python opencv
date:   2019-09-17
---

<!---
版本    日期    作者    描述
v1.0    2019.09.17  lous    文件创建

-->

## 安装

`pip install opencv-python` 安装封装后opencv模块

速度慢可以切换为国内源

`pip install opencv-python  -i https://pypi.tuna.tsinghua.edu.cn/simple`

pip国内的一些镜像

- 阿里云 https://mirrors.aliyun.com/pypi/simple/
- 中国科技大学 https://pypi.mirrors.ustc.edu.cn/simple/
- 豆瓣(douban) http://pypi.douban.com/simple/
- 清华大学 https://pypi.tuna.tsinghua.edu.cn/simple/
- 中国科学技术大学 http://pypi.mirrors.ustc.edu.cn/simple/

## 训练模板

下载的是opencv 4.1.0 
居然 [没有自带](https://github.com/opencv/opencv/issues/13231) createsamples 和 traincascade

下载了 3.4.7 `opencv\build\x64\vc15\bin` 里面确实有

## 样本

收集了1800+正样本

负样本直接随便拍了一个视频
据说1:3的比例比较合适，所以视频拍了2分钟，还是不够
19fps，6000张要300s……五分钟

`dir /b >pos.txt`  生成文本列表

生成正样本vec文件

`opencv_createsamples.exe -vec pos.vec -info info.dat -num 900 -w 150 -h 150`


`opencv_traincascade.exe -data xml -vec pos.vec -bg bg.txt -numPos 300 -numNeg 900 -numStages 10 -w 150 -h 150 -minHitRate 0.999 -maxFalseAlarmRate 0.2 -weightTrimRate 0.95 -featureType LBP`

写了几个脚本

直接用视频生成负样本

视频越多越好，我测试的时候直接是每隔30s取一帧作为负样本。除非视频卡住，不然效果应该还可以。

训练的时间真心长1800+ 20x20 的正样本 5000 64x36 的负样本

笔记本 CPU i5-4210M 2.6GHz

stage=5，训练10min才到了4


根本不敢想象15层以上要训练多久

后面得测试下样本数和阶数与时间之间的大概关系

## 测试过程中的问题


- 

`Traincascade Error: Bad argument (Can not get new positive sample. The most possible reason is insufficient count of samples in given vec-file`

```
The problem is that your vec-file has exactly the same samples count that you passed in command line -numPos. Training application used all samples from the vec-file to train 0-stage and it can not get new positive samples for the next stage training because vec-file is over.The bug of traincascade is that it had assert() in such cases, but it has to throw an exception with error message for a user. It was fixed in r8913.

-numPose  is a samples count that is used to train each stage. Some already used samples can be filtered by each previous stage (ie recognized as background), but no more than (1 - minHitRate) * numPose on each stage. So vec-file has to contain >= (numPose + (numStages-1) * (1 - minHitRate) * numPose) + S, 
where S is a count of samples from vec-file that can be recognized as background right away. I hope it can help you to create vec-file of correct size and chose right numPos value.
```
- 误检率太高了

`traincascade's error (Required leaf false alarm rate achieved. Branch training terminated.)`

把阶数加上去

## 训练参数

正样本中会有被识别成负样本并被剔除掉的，所以 numPos 最好不要直接等于我们样本总数

```
minHitRate 0.999
numPos 1800
numNeg 5000
numStages 5

假设我们正样本中有 bg_ratio 的比例是负样本

vec_num >(numPos +(numStages-1)*(1-minHitRate)*numPos)+S
        >numPos * (1+ bg_ratio + (numStages-1)*(1-minHitRate) )
        >1800 *(1+0.02 +4 *0.001)
```

给5%的比例认为会被提出应该足够了



## 参考


- [更换pip源到国内镜像](https://blog.csdn.net/chenghuikai/article/details/55258957)

- [级联分类器训练](http://www.opencv.org.cn/opencvdoc/2.3.2/html/doc/user_guide/ug_traincascade.html?highlight=opencv_traincascade)

-[使用OpenCV训练Haar like+Adaboost分类器的常见问题](https://www.cnblogs.com/chensheng-zhou/p/5542887.html)




