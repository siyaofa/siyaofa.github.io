---
layout: page
title: 控制器
date:   2019-06-04
---

控制系统的核心内容。

## 功能

功能：通过逻辑计算，把逻辑值下发给执行器，从而改变被控对象的状态。

```mermaid
graph LR;

    控制器-->执行器;
    执行器-->被控对象;
    被控对象-->传感器;
    传感器-->控制器;

```

## 常见控制器

### PID控制器

无模型控制器，不需预先知道系统的传递函数就可以使用。

神奇的是PID控制器在绝大多数工程中可可用的，我们只需要调节PID参数即可获取到一个不错的控制效果。

更加详细内容请参见[PID控制器详情](PID.md)

#### 连续PID控制器

$$
u(t)=K_pe(t)+K_i\int_0^te(\tau)d\tau+K_d\frac{d}{dt}e(t)
$$

$u(t)$ 为控制器输出
$e(t)$ 为设定值(Set Point)和测量值(Process Value)

对上式做拉式变换，可以得到PID控制器的传递函数

$$
G(s)=K_p+\frac{K_i}{s}+K_ds=\frac{K_ds^2+K_ps+K_i}{s}
$$


![PID传递函数](../pic/Gs_kp_0.7_ki_0.03_kd_0.01.gif)

把$K_p$提取出来，可以写成标准PID形式

$$
u(t)=K_p(e(t)+\frac{1}{T_i}\int_0^te(\tau)d\tau+T_d\frac{d}{dt}e(t))
$$

$T_i$ 积分时间
$T_d$ 微分时间

因为标准形式的PID表达式各项系数都有着具体的物理含义，所以工程上一般使用标准形式的PID表达式。

### LQG控制器

https://zh.wikipedia.org/zh-hans/LQG%E6%8E%A7%E5%88%B6
https://baike.baidu.com/item/LQR

https://blog.csdn.net/heyijia0327/article/details/39270597

https://wenku.baidu.com/view/ca8f8b68b84ae45c3b358c9a.html

LQG即线性二次高斯控制

### MPC

https://baike.baidu.com/item/MPC/3586091




