---
layout: page
title: Laplace变换 Z变换之间的关系
---

### $\mathcal{S}$域$\mathcal{Z}$域映射关系

复数S平面

$$
s=\sigma+j\omega
$$

说明$\mathcal{S}$域是个直角坐标系，其中$\sigma$是实轴坐标，$\omega$是虚轴坐标

复数Z平面

$$
z=e^{sT}=e^{(\sigma+j\omega)T}=e^{ \sigma T } e^{j \omega T}=re^{j \omega T}
$$

其中$r=e^{ \sigma T }$

$\sigma<0\rightarrow r<1$

$\mathcal{S}$域上是左半平面，$\mathcal{Z}$域上是单位圆内。

$\sigma =0 \rightarrow r=1$ 
$\mathcal{S}$域上是虚轴，$\mathcal{Z}$域上是单位圆。

$ \sigma >0 \rightarrow r>1$ 

$\mathcal{S}$域上是右半平面，$\mathcal{Z}$域上是单位圆外。

这也是为什么控制理论中判断系统稳定性时，S域判断的是极点在否左半平面，Z域判断极点是否在单位圆内。

>个人理解：可能涉及到了拓扑学中的内容，S域平面向左边挤压成一个圆。其几何形状虽然发生了变化，但是相互之间的位置维系依旧保存下来了（Z与S之间转换的边界除外）。
