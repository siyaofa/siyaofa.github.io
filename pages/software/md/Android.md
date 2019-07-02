---
layout: page
title: Android
date:   2019-07-02
---



## Android 基本知识

由后台任务和界面UI组成

每个界面可以理解为一个Activity

开发过程应注意Activity生命周期

之间依靠Intent通讯，可以传递数据

除少数特殊服务外，大多数都有界面

## 项目结构

src/main/java 下就是java源码的路径

src/main/res 存放资源文件

src/main/res/layout 界面布局

AndroidManifest.xml 为整个项目的配置

我们暂时只关心上面几个路径

## 相机基本使用

因为我们需要拍摄，并给出魔方限定区域，因此不能直接使用子带的相机界面，只能自己定制预览窗口。


界面开发比想象中的要复杂很多，预计需要一个星期才能基本采集到想要的图像。


