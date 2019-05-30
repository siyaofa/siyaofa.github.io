# 示例项目

这篇文章将会介绍如何用Python2.7 和opencv-python2.4 及Vpython 通过摄像头获取到魔方的当前状态，并通过动画 演示如何还原到最初始的状态。 假设你已经具备了如下条件：

 ![扫描关注](https://siyaofa.github.io/pic/QR4.jpg)

1 已经安装了Python2.7，opencv2.4 for python， Vpython的windows平台的电脑。

2 了解基本的图像处理和模式识别的原理

3 具备基本的 python 编程能力和Vpython 动画渲染的能力

4 最重要的是有一个3阶魔方……

现在将正式进入到正文内容

各软件的安装本文暂不作介绍，后续将会补上(白条打款处)

因为魔方具体的还原算法是用别人已经编译好的exe文件算的，因此暂时不支持跨平台编译

1 [如何在图像中定位到魔方所在的位置](page/训练cascade分类器)

2 [识别魔方当前状态并建立还原动画](page/move)

3 [源码行数统计脚本](page/source_total_lines_count)