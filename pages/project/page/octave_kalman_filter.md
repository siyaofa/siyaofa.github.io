---
layout: page
title: Octave 卡尔曼滤波器仿真
---

<!---
版本    日期    作者    描述
v1.0    2019.06.16  lous    文件创建
-->

多传感器信息融合中经常会使用到卡尔曼滤波器。

具体推导过程请参见[滤波器](../../controller/page/filter.md)

## 迭代过程

预测阶段

1. $ \hat{x}_k^- = A \hat{x}_{k-1} + B u_{k-1} $
2. $P_k^- = A P_{k-1} A^T + Q$

估计阶段

3. $ K_k = P_k^- H^T (H P_k^- H^T + R)^{-1} $
4. $ P_k = (I - K_kH)P_k^-$
5. $ \hat{x}_k = \hat{x}_k^- + K_k (z_k - H \hat{x}_k^-) $