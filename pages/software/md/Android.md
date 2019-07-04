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

`SurfaceHolder`预览相机内容

通过如下代码可直接调用系统api拍摄照片

```java
Intent intent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
                intent.putExtra("android.intent.extras.CAMERA_FACING_FRONT", 1);
                // 调用前置摄像头
                startActivityForResult(intent, 1);
```
在这一步的基础上，需要在拍摄的时候给出一个拍摄的区域，类似二维码扫码时的界面。

拍摄完成后我们只保存选定的正方形区域


## 截取并保存图像

给应用申请权限

```xml
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
```

Android 7 以上还需要动态申请



## 参考

- [Android 基础入门教程 使用Camera拍照](http://www.runoob.com/w3cnote/android-tutorial-camera.html)
- [解决安卓7.0系统写入SD卡权限失败问题](https://blog.csdn.net/wi2rfl78/article/details/78314286)

