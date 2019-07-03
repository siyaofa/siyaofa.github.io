---
layout: page
title: 魔方还原算法
date:   2019-06-25
---
<!---
版本    日期    作者    描述
v1.0    2019.06.25  lous    文件创建
-->

为了完成在校时的愿望，最近开始拾起了魔方还原助手的。最终目标：上架各大应用市场，作为一款应用软件为广大魔方爱好者提供帮助。

如果你对此项目也感兴趣，请不要重复造轮子。我们会非常欢迎的你加入！

[魔方状态识别](rubik_cube_state_recognition)完成后，我们可以开始求解还原步骤了

主流的算法有

## kociemba

直接用了python kociemba 1.2.1

```python
kociemba.solve('DLBLUUDDRFBRFRFFURBBURFRRLUUBLDDFUDFLFLULBBLBDUFDBRDRL')

"R F2 B' U' B' D2 F U2 D' L U2 R2 B2 L2 U R2 U' D2 R2 D"
```

使用非常简单，考虑到要在手机上实现，目前有两个方案

1. 使用C编程为库，在Android调用
2. 用java原始实现

目前两种方案都有开源包可用

为未来跨平台实现，倾向方案1

但因目前只有Android开发环境，暂时用方案2测试实现。


## 算法原理



##


## 参考

- [kociemba 1.2.1](https://pypi.org/project/kociemba/)
- [Kociemba算法学习](https://my.oschina.net/goodmoon/blog/1502701)


