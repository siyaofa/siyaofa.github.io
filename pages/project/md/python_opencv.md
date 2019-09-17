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

## 参考


- [更换pip源到国内镜像](https://blog.csdn.net/chenghuikai/article/details/55258957)

- [级联分类器训练](http://www.opencv.org.cn/opencvdoc/2.3.2/html/doc/user_guide/ug_traincascade.html?highlight=opencv_traincascade)






