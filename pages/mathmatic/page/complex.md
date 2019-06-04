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

$$
X(\omega)={\int_{-\infty}^\infty}x(t)e^{-j{\omega}t}dt
$$

### [拉普拉斯变换](https://baike.baidu.com/item/%E6%8B%89%E6%99%AE%E6%8B%89%E6%96%AF%E5%8F%98%E6%8D%A2)

$$
X(s)={\int_0^\infty}x(t)e^{-st}dt
$$

其中

$$s=\sigma+j\omega$$



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


