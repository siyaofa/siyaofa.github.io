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

[UNC 推导](https://www.cs.unc.edu/~welch/media/pdf/kalman_intro.pdf)


#### 过程估计
假设状态向量为$x$则$k$时刻的状态可由$k-1$时刻的状态表示如下：

$$
x_k=Ax_{k-1}+Bu_{k-1}+w_{k-1}
$$

$u_k$为$k$时刻的系统输入，$w_k$为$k$时刻的过程噪声。

因为测量存在误差，假设$x_k$的观测值$z_k$：

$$
z_k=Hx_k+v_k
$$

$v_k$为$k$时刻的测量噪声。

假设$v$和$w$都为白噪声。

#### 滤波器计算

先验估计（预测）误差

$$
e_k^- \equiv x_k - \hat{x} _k^- 
$$

后验估计（测量）误差

$$
e_k \equiv x_k - \hat{x} _k 
$$

估计误差的协方差
$$
P_k^-=E[ e_k^- e_k^{-T}]
$$

$$
P_k=E[ e_k e_k^T]
$$

$$
\hat{x}_k=\hat{x}_k^- + K(z_k - H \hat{x}_k^-)
$$



增益系数$K$代表着先验值的权重。

$$
K_k = P_k^- H^T (H P_k^- H^T + R)^{-1} \\
=\frac{P_k^-H^T}{H P_k^- H^T + R}
$$


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