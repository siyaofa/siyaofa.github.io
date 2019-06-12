---
layout: page
title: Multiwii 分析
---

<!---
版本    日期    作者    描述
v1.0    2019.06.13  lous    文件创建

-->

在校期间设计搭建了一套四旋翼飞行器

控制器MCU是Arduino Uno

飞控用了开源项目 [Multiwii](http://www.multiwii.com/wiki/?title=Main_Page)

框架、电机、电调、电池、遥控、旋翼都是自己选型购买的

整体尺寸较大，且笨重。

且对电机和旋翼的功率设计分析欠缺，差点导致飞行器无法离地。
最终更换为三叶桨才使勉强能够进行常规飞行。

特技什么的是根本不能实现的。

现在回想起来当时的调试过程依旧觉得很美好。

## Multiwii 飞控

Multiwii是一开源的飞控项目。能够兼容绝大多数市面上常见的飞行器。

包括固定翼和多旋翼，且结构适配性较好。

项目主要分为两个部分

- 飞行控制固件
- 调试GUI界面

### Multiwii 固件

Github 固件源码 https://github.com/multiwii/multiwii-firmware

[Google网盘](https://code.google.com/archive/p/multiwii/)

|源文件|说明|
--|--
Alarms.h Alarms.cpp|错误状态指示，警报。
config.h | 配置文件，根据硬件结构等配置相关选项。[配置含义](https://www.cnblogs.com/Tranquilty/p/4848853.html)
def.h|
EEPROM.h EEPROM.cpp|Electrically Erasable Programmable read only memory. 用于保存调试下发的配置参数，例如PID参数。
GPS.h GPS.cpp| GPS传感器读数获取 <br> 位置估计 <br> 路径规划
IMU.h IMU.cpp|  Inertial Measurement Unit.<br> 对加速度、陀螺仪、气压计、磁力等传感器读数进行估计
LCD.h LCD.cpp|液晶屏操作，主要用来显示状态信息和错误信息
MultiWii.cpp|主循环，包含三个抽象轴的控制器。
MultiWii.h|
MultiWii.ino|Arduino项目的文件。实际是空的，实现都在cpp内。
Output.h Output.cpp|电机输出
Protocol.h Protocol.cpp|串口通信协议
RX.h RX.cpp| 接收模块，接受来自遥控器的指令并解析。
Sensors.h Sensors.cpp| 获取加速度传感器、陀螺仪、气压计、磁力计和超声波传感器的原始值。
Serial.h Serial.cpp| 串口通讯模块，应该是调试GUI程序使用的。
Telemetry.h Telemetry.cpp|
types.h|


### Multiwii GUI 

可以参考这个[入门教程](https://blog.csdn.net/yjy728/article/details/69934993)

