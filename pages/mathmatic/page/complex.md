---
layout: page
title: 复数
---

$$
z=a+bi
$$


## 复数的起源

[comment]: <> (<img src="http://latex.codecogs.com/svg.latex?z=a+bi" />)

## 复数的意义

把问题求解的作用域扩充了。在某些条件下实数域无法求解，而复数域可以求解。
这是因为复数域是二维的，而实数域是一维的。

### 参考

[百度百科](https://baike.baidu.com/item/%E5%A4%8D%E6%95%B0/254365)

### [傅里叶变换](https://baike.baidu.com/item/%E5%82%85%E9%87%8C%E5%8F%B6%E5%8F%98%E6%8D%A2)

#### 连续傅里叶变换

正变换

$$
X(\omega)=\frac{1}{\sqrt{2\pi}}{\int_{-\infty}^\infty}x(t)e^{-i{\omega}t}dt
$$

逆变换

$$
x(t)=\frac{1}{\sqrt{2\pi}}{\int_{-\infty}^\infty}X(\omega)e^{i{\omega}t}d\omega
$$

![image](../pic/Fourier_transform_time_and_frequency_domains_(small).gif)


### [拉普拉斯变换](https://baike.baidu.com/item/%E6%8B%89%E6%99%AE%E6%8B%89%E6%96%AF%E5%8F%98%E6%8D%A2)


正变换

$$
F(s)={\int_0^\infty}f(t)e^{-st}dt
$$

其中

$$s=\sigma+j\omega$$

逆变换

$$
f(t)={\mathcal{L}^{-1}}[F(s)]=\frac{1}{2{\pi}j}{\int}_{\beta-j\infty}^{\beta+j\infty}F(s)e^{st}ds
$$



### [$\mathcal{Z}$变换](https://baike.baidu.com/item/Z%E5%8F%98%E6%8D%A2)

维基百科中关于$\mathcal{Z}$变换的定义如下

>$\mathcal{Z}$变换是把一连串离散的实数或复数信号，从时域转为复频域的表示。
可以认为是拉普拉斯变换的离散时间等价。


#### 双边$\mathcal{Z}$变换

时域信号$X[n]$的$\mathcal{Z}$变换

$$
X(z)=\mathcal{Z}\{x[n]\}=\sum_{n=-\infty}^{\infty}x[n]z^{-n}
$$

其中

$$
z=Ae^{j\phi}=A(\cos{\phi}+j\sin{\phi})
$$

#### 双边$\mathcal{Z}$变换

$$
X(z)=\mathcal{Z}\{x[n]\}=\sum_{n=0}^{\infty}x[n]z^{-n}
$$

#### 逆$\mathcal{Z}$变换

$$
x[n]=\mathcal{Z}^{-1}\{X(z)\}=\frac{1}{2{\pi}j}{\oint_C}X(z)z^{n-1}dz
$$

### 三种变换之间的关系

[傅立叶变换、拉普拉斯变换、Z 变换的联系是什么？为什么要进行这些变换？研究的都是什么？](https://www.zhihu.com/question/22085329)

问题下的几个高赞回答都很有质量。

引用对于三者关系的总结

>拉普拉斯变换与连续时间傅里叶变换的关系是：
拉普拉斯变换将频率从实数推广为复数，因而傅里叶变换变成了拉普拉斯变换的一个特例。
当$s$为纯虚数时，$x(t)$的拉普拉斯变换，即为$x(t)$的傅里叶变换。
并不是通过拉氏变换和$\mathcal{Z}$变换获取不满足狄利克雷条件的函数的傅氏变换。事实上由于收敛域的问题，这些函数的傅氏变换是不收敛的，即使通过拉氏变换和Z变换也不可能获得这些函数的傅氏变换。
拉氏变换和$\mathcal{Z}$变换的意义，是将频率域的某些限制条件A，转化为复频率域中与之等价的相应条件A'，然后在复频域内直接观察信号或系统的拉氏变换或Z变换，看$X(\mathcal{s})$或$X(\mathcal{z})$是否满足条件A'，得到相应的结论。用这个结论代替拉氏变换的结论（因为拉氏变换不存在，无法得出结论）。

最后一句话作者应该表达的是傅氏变换结论。

### $\mathcal{S}$域$\mathcal{Z}$域映射关系

复数S平面

$$
s={\sigma}+j{\omega}
$$

说明$s$域是个直角坐标系，其中

${\sigma}$ 是实轴坐标，${\omega}$ 是虚轴坐标

复数Z平面

$$
z=e^{sT}=e^{({\sigma}+j\omega)T}=e^{{\sigma}T}e^{j{\omega}T}=re^{j{\omega}T}
$$

其中$r=e^{{\sigma}T}$

1.$\sigma<0{\rightarrow}r<1$， $\mathcal{S}$域上是左半平面，$\mathcal{Z}$域上是单位圆内。
2.$\sigma=0{\rightarrow}r=1$，$\mathcal{S}$域上是虚轴，$\mathcal{Z}$域上是单位圆。
3.$\sigma>0{\rightarrow}r>1$，$\mathcal{S}$域上是右半平面，$\mathcal{Z}$域上是单位圆外。

这也是为什么控制理论中判断系统稳定性时，S域判断的是极点在否左半平面，Z域判断极点是否在单位圆内。

>个人理解：可能涉及到了拓扑学中的内容，S域平面向左边挤压成一个圆。其几何形状虽然发生了变化，但是相互之间的位置维系依旧保存下来了（Z与S之间转换的边界除外）。

### $\mathcal{S}$域$\mathcal{Z}$域转换

#### Tustin变换

采样周期为

$$
T=\frac{2\pi}{{\omega}_s}
$$

其中${\omega_s}$为采样频率（rad/s）

两者之间的关系为

$$
z=e^{sT}=e^{(\sigma+j\omega)T}=e^{{\sigma}T}e^{j{\omega}T} \\
=e^{{\sigma}{\frac{2\pi}{{\omega}_s}}}e^{j{\omega}{\frac{2\pi}{{\omega}_s}}}
$$

##### $\mathcal{S}{\rightarrow}\mathcal{Z}$

$$
z=e^{sT}=\frac{e^{sT/2}}{e^{-sT/2}}{\approx}\frac{1+sT/2}{1-sT/2}
$$

##### $\mathcal{Z}{\rightarrow}\mathcal{S}$

$$
s=\frac{ln(z)}{T}{\approx}\frac{2}{T}\frac{z-1}{z+1}=\frac{2}{T}\frac{1-z^{-1}}{1+z^{-1}}
$$

通过Tustin变换就可以把S域的传递函数用时序数字信号的输入和输出表示出来。
