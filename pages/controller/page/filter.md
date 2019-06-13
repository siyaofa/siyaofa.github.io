---
layout: page
title: 滤波器
---

<!---
版本    日期    作者    描述
v1.0    2019.06.04  lous    文件创建

-->

数字滤波器

## 滤波器

FIR(Finite Impulse Response)滤波器：有限长单位冲激响应滤波器
IIR()

### 一阶滤波器

### 二阶滤波器

### 卡尔曼滤波器

### 陷波滤波器 (notch filter)

理想情况下陷波滤波器是个点阻滤波器，实际工程上是一个非常窄的带阻滤波器。

[NYU 解释](engineering.nyu.edu/mechatronics/Control_Lab/Padmini/Fiberoptics/Notch_Filter.doc)

滤波器传递函数

$$
G(s)=\frac{s^2+\omega_n^2}{s^2+2\omega_ns+\omega_n^2}
$$

其Bode图如下

![bode图](../../project/pic/octave_NYU_notch_filter_bode_50hz.jpg)


## 相关资源

[如何快速设计一个FIR滤波器（一）](https://zhuanlan.zhihu.com/p/45138629)