# siyaofa的博客

blog 这篇文章将会介绍如何用Python2.7 和opencv-python2.4 及Vpython 通过摄像头获取到魔方的当前状态，并通过动画 演示如何还原到最初始的状态。 假设你已经具备了如下条件：
```markdown
1.电脑上已经安装了Python2.7，opencv2.4 for python， Vpython。
（目前版本只支持windows 系统，并且测试是在 x64_win10）。
2.了解基本的图像处理和模式识别的原理
3.具备基本的 python 编程能力和Vpython 动画渲染的能力
4.最重要的是知道该如何玩魔方…… 现在将正式进入到正文内容
```
你可以从这里看关于[魔方助手](https://siyaofa.github.io/help)的介绍，以及如何使用魔方助手去还原一个3x3x3的魔方
你也可以[在线阅读pdf文档](https://siyaofa.github.io/pdf/cube)或[直接下载](https://siyaofa.github.io/pdf/cube.pdf)
