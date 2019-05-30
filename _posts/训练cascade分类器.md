---
layout: page
title: cascade
---

这篇文章将会告诉你如何利用OpenCV中自带的程序opencv\_createsamples.exe和opencv\_traincascade.exe创建样本并训练训练级联Adaboost分类器。（前提需要把OpenCV安装目录下这两个文件的路径加入到系统的环境变量中）

准备工作如下：

1. 一些魔方的样本，并且样本中只包含魔方，记为正样本

2. 一些背景的样本，并且背景中不包含有魔方，记为负样本

3. 把魔方和背景图片从彩色，转换为灰度图像

4. 并把魔方规范到24x24像素

5. 背景大小没有特定要求，但是一定要大于24x24

先上结果图

![image](media/d1954998aaff1a9f2043c7b6810f7f07.png)

![image](media/37cd79ebaf1577c4182ce98e801c0f5b.png)

把所有的正样本放于文件夹pos，所有的负样本放于文件夹neg中。

pos文件夹下，cmd执行dir /b\>pos.txt

打开生成的pos.txt去掉第一行或者最后一行的pos.txt。把所有的 jpg 替换成 jpg 1 0 0
24 24。

![](media/4eafc7ce0fd98a1e3386970b9a584937.png)

neg文件夹下，cmd执行dir /b\>neg.txt

打开生成的neg.txt去掉第一行或者最后一行的neg.txt。

在每行的开始加入neg/

![](media/6d5ce5ce6bc6a0683b71a77045d547ff.png)

准备训练样本

Cmd下执行opencv\_createsamples.exe -info pos\\pos.txt -vec pos.vec -bg
neg\\neg.txt -num 2681 -w 24 -h 24

Info file name: pos\\pos.txt

得到如下的结果，表明成功

Img file name: (NULL)
Vec file name: pos.vec
BG file name: neg\\neg.txt
Num: 2681
BG color: 0
BG threshold: 80
Invert: FALSE
Max intensity deviation: 40
Max x angle: 1.1
Max y angle: 1.1
Max z angle: 0.5
Show samples: FALSE
Width: 24
Height: 24
Max Scale: -1
Create training samples from images collection...
Done. Created 2681 samples

直接输入opencv\_createsamples.exe显示帮助信息

接下来开始训练样本

Cmd下执行opencv\_traincascade.exe -data xml -vec pos.vec -bg neg\\neg.txt
-numpos 2681 -numneg 1102 -numstages 20 -featureType LBP -w 24 -h 24

得到

PARAMETERS:
cascadeDirName: xml
vecFileName: pos.vec
bgFileName: neg\\neg.txt
numPos: 2000
numNeg: 1000
numStages: 20
precalcValBufSize[Mb] : 1024
precalcIdxBufSize[Mb] : 1024
acceptanceRatioBreakValue : -1
stageType: BOOST
featureType: LBP
sampleWidth: 24
sampleHeight: 24
boostType: GAB
minHitRate: 0.995
maxFalseAlarmRate: 0.5
weightTrimRate: 0.95
maxDepth: 1
maxWeakCount: 100
Number of unique features given windowSize [24,24] : 8464

![](media/69d5e404c700781586a7fdb310ca3da1.png)

静静的等待训练就可以了。在我的笔记本上训练时间大概为25mins。

其中会有一些问题，请参考[stackoverflow](http://stackoverflow.com/questions/16058080/how-to-train-cascade-properly)和[OpenCV中Adaboost训练的经验总结](http://blog.csdn.net/xidianzhimeng/article/details/42147601)

打开生成目录xml，其中的cascade.xml就是后面程序中需要的特征分类器。

为了方便区分，重名名为cube\_cascade.xml

对自带的人脸识别作简单的修改

```python
import cv2
import os
import os.path

cube=cv2.CascadeClassifier("cube_cascade.xml")
n=0
if n==0:
	cam = cv2.VideoCapture(0)
	while True:
		_, img = cam.read()
		gray_img = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
		cubes = cube.detectMultiScale(gray_img, 1.3, 5)
		for cube_x,cube_y,cube_w,cube_h in cubes:
			cv2.rectangle(img, (cube_x, cube_y), (cube_x+cube_w, cube_y+cube_h), (0,255,0), 2)
		cv2.imshow('img', cv2.flip(img,1))			
		key = cv2.waitKey(30) & 0xff
		if key == 27:
			break
	cam.release()
	cv2.destroyAllWindows()
else:
	imgDir='test_img'
	alpha=10
	for parent,dirname,filenames in os.walk(imgDir):
		for filename in filenames:
			print(imgDir+'/'+filename)
			img=cv2.imread(imgDir+'/'+filename)
			res = cv2.resize(img, (0,0), fx=1.0/alpha, fy=1.0/alpha)
			gray_img = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
			cubes = cube_haar.detectMultiScale(gray_img, 1.3, 5)
			for cube_x,cube_y,cube_w,cube_h in cubes:
				cv2.rectangle(img, (cube_x, cube_y), (cube_x+cube_w, cube_y+cube_h), (0,255,0), 2)
			cv2.imshow(filename,res)
	while True:
		key = cv2.waitKey(30) & 0xff
		if key == 27:
			cv2.destroyAllWindows()
			break	
	

```


再加两张图

![](media/75d7027f16de9eca3369464f0d40069e.png)

![](media/2a7e70ff2827246ab72638b14ea2f9ac.png)

当然实验结果还是有点问题的，分类器并不是很好。实时的准确率大概只有80\~90%。

因为魔方样本不是很多，500多个重复了4次。。。。

如果你对图像识别也感兴趣，可以联系[siyaofa@outlook.com](可以联系siyaofa@outlook.com)标明主题rubikcube+python+opencv+vpython

转载请著名[Siyaofa](https://siyaofa.github.io/)

Siyaofa all copyrights reserves
