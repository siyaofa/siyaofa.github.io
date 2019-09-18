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

stage=6，训练10min才到了4

```
===== TRAINING 5-stage =====
<BEGIN
POS count : consumed   1856 : 1861
NEG count : acceptanceRatio    5001 : 0.000506669
Precalculation time: 1.482
+----+---------+---------+
|  N |    HR   |    FA   |
+----+---------+---------+
|   1|        1|        1|
+----+---------+---------+
|   2|        1|        1|
+----+---------+---------+
|   3|        1|        1|
+----+---------+---------+
|   4|        1|        1|
+----+---------+---------+
|   5|        1| 0.867427|
+----+---------+---------+
|   6|        1| 0.604079|
+----+---------+---------+
|   7| 0.999461| 0.546891|
+----+---------+---------+
|   8| 0.999461| 0.438112|
+----+---------+---------+
|   9| 0.999461| 0.356929|
+----+---------+---------+
|  10| 0.999461| 0.323935|
+----+---------+---------+
|  11| 0.999461| 0.239552|
+----+---------+---------+
|  12| 0.999461| 0.152769|
+----+---------+---------+
END>
Training until now has taken 0 days 0 hours 44 minutes 46 seconds.
```
根本不敢想象15层以上要训练多久

后面得测试下样本数和阶数与时间之间的大概关系

```
opencv_traincascade.exe -data xml -vec pos.vec -bg bg.txt -numPos 1772 -numNeg 3532 -numStages 5 -w 20 -h 20 -minHitRate 0.999000 -maxFalseAlarmRate 0.2 -weightTrimRate 0.95 -featureType LBP
PARAMETERS:
cascadeDirName: xml
vecFileName: pos.vec
bgFileName: bg.txt
numPos: 1772
numNeg: 3532
numStages: 5
precalcValBufSize[Mb] : 1024
precalcIdxBufSize[Mb] : 1024
acceptanceRatioBreakValue : -1
stageType: BOOST
featureType: LBP
sampleWidth: 20
sampleHeight: 20
boostType: GAB
minHitRate: 0.999
maxFalseAlarmRate: 0.2
weightTrimRate: 0.95
maxDepth: 1
maxWeakCount: 100
Number of unique features given windowSize [20,20] : 3969


===== TRAINING 4-stage =====
<BEGIN
POS count : consumed   1772 : 1776
NEG count : acceptanceRatio    3532 : 0.0029611
Precalculation time: 0.98
+----+---------+---------+
|  N |    HR   |    FA   |
+----+---------+---------+
|   1|        1|        1|
+----+---------+---------+
|   2|        1|        1|
+----+---------+---------+
|   3|        1|        1|
+----+---------+---------+
|   4|        1|        1|
+----+---------+---------+
|   5|        1| 0.851076|
+----+---------+---------+
|   6| 0.999436| 0.627973|
+----+---------+---------+
|   7| 0.999436| 0.428935|
+----+---------+---------+
|   8| 0.999436|  0.44026|
+----+---------+---------+
|   9| 0.999436|  0.36325|
+----+---------+---------+
|  10| 0.999436| 0.229049|
+----+---------+---------+
|  11| 0.999436| 0.250566|
+----+---------+---------+
|  12| 0.999436| 0.178652|
+----+---------+---------+
END>
Training until now has taken 0 days 0 hours 5 minutes 15 seconds.


```

```
opencv_traincascade.exe -data xml -vec pos.vec -bg bg.txt -numPos 1772 -numNeg 3532 -numStages 4 -w 20 -h 20 -minHitRate 0.999000 -maxFalseAlarmRate 0.2 -weightTrimRate 0.95 -featureType LBP
PARAMETERS:
cascadeDirName: xml
vecFileName: pos.vec
bgFileName: bg.txt
numPos: 1772
numNeg: 3532
numStages: 4
precalcValBufSize[Mb] : 1024
precalcIdxBufSize[Mb] : 1024
acceptanceRatioBreakValue : -1
stageType: BOOST
featureType: LBP
sampleWidth: 20
sampleHeight: 20
boostType: GAB
minHitRate: 0.999
maxFalseAlarmRate: 0.2
weightTrimRate: 0.95
maxDepth: 1
maxWeakCount: 100
Number of unique features given windowSize [20,20] : 3969

===== TRAINING 3-stage =====
<BEGIN
POS count : consumed   1772 : 1775
NEG count : acceptanceRatio    3532 : 0.0116949
Precalculation time: 1.026
+----+---------+---------+
|  N |    HR   |    FA   |
+----+---------+---------+
|   1|        1|        1|
+----+---------+---------+
|   2|        1|        1|
+----+---------+---------+
|   3|        1|        1|
+----+---------+---------+
|   4| 0.999436|  0.77265|
+----+---------+---------+
|   5| 0.999436| 0.738392|
+----+---------+---------+
|   6|        1| 0.661099|
+----+---------+---------+
|   7| 0.999436| 0.535391|
+----+---------+---------+
|   8| 0.999436| 0.453851|
+----+---------+---------+
|   9| 0.999436|   0.3641|
+----+---------+---------+
|  10| 0.999436| 0.232163|
+----+---------+---------+
|  11| 0.999436| 0.168743|
+----+---------+---------+
END>
Training until now has taken 0 days 0 hours 1 minutes 4 seconds.

```


减少样本

```
opencv_traincascade.exe -data xml -vec pos.vec -bg bg.txt -numPos 475 -numNeg 1000 -numStages 5 -w 20 -h 20 -minHitRate 0.999000 -maxFalseAlarmRate 0.2 -weightTrimRate 0.95 -featureType LBP
PARAMETERS:
cascadeDirName: xml
vecFileName: pos.vec
bgFileName: bg.txt
numPos: 475
numNeg: 1000
numStages: 5
precalcValBufSize[Mb] : 1024
precalcIdxBufSize[Mb] : 1024
acceptanceRatioBreakValue : -1
stageType: BOOST
featureType: LBP
sampleWidth: 20
sampleHeight: 20
boostType: GAB
minHitRate: 0.999
maxFalseAlarmRate: 0.2
weightTrimRate: 0.95
maxDepth: 1
maxWeakCount: 100
Number of unique features given windowSize [20,20] : 3969


===== TRAINING 4-stage =====
<BEGIN
POS count : consumed   475 : 475
NEG count : acceptanceRatio    1000 : 0.00807324
Precalculation time: 0.089
+----+---------+---------+
|  N |    HR   |    FA   |
+----+---------+---------+
|   1|        1|        1|
+----+---------+---------+
|   2|        1|        1|
+----+---------+---------+
|   3|        1|    0.538|
+----+---------+---------+
|   4|        1|    0.698|
+----+---------+---------+
|   5|        1|    0.359|
+----+---------+---------+
|   6|        1|    0.359|
+----+---------+---------+
|   7|        1|    0.218|
+----+---------+---------+
|   8|        1|    0.085|
+----+---------+---------+
END>
Training until now has taken 0 days 0 hours 0 minutes 28 seconds.


```


```
opencv_traincascade.exe -data xml -vec pos.vec -bg bg.txt -numPos 475 -numNeg 1000 -numStages 7 -w 20 -h 20 -minHitRate 0.999000 -maxFalseAlarmRate 0.2 -weightTrimRate 0.95 -featureType LBP
PARAMETERS:
cascadeDirName: xml
vecFileName: pos.vec
bgFileName: bg.txt
numPos: 475
numNeg: 1000
numStages: 7
precalcValBufSize[Mb] : 1024
precalcIdxBufSize[Mb] : 1024
acceptanceRatioBreakValue : -1
stageType: BOOST
featureType: LBP
sampleWidth: 20
sampleHeight: 20
boostType: GAB
minHitRate: 0.999
maxFalseAlarmRate: 0.2
weightTrimRate: 0.95
maxDepth: 1
maxWeakCount: 100
Number of unique features given windowSize [20,20] : 3969

===== TRAINING 6-stage =====
<BEGIN
POS count : consumed   475 : 475
NEG count : acceptanceRatio    1000 : 0.00128723
Precalculation time: 0.087
+----+---------+---------+
|  N |    HR   |    FA   |
+----+---------+---------+
|   1|        1|        1|
+----+---------+---------+
|   2|        1|        1|
+----+---------+---------+
|   3|        1|    0.573|
+----+---------+---------+
|   4|        1|    0.678|
+----+---------+---------+
|   5|        1|    0.352|
+----+---------+---------+
|   6|        1|    0.333|
+----+---------+---------+
|   7|        1|     0.23|
+----+---------+---------+
|   8|        1|    0.073|
+----+---------+---------+
END>
Training until now has taken 0 days 0 hours 3 minutes 37 seconds.

```

测试之后发现深度增大之后对检测效果有改善

加大后继续测试

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




