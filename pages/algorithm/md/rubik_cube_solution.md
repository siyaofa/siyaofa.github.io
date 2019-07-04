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

kociemba二阶算法

群论

IDA*



## Android 测试

直接用了Kociemba twophase的jar包，程序直接卡住了。

把源码包含至工程后，做适当修改并加了打印信息。


手机： 小米8 SE 芯片 ： 高通骁龙710
```
2019-07-04 21:58:44.951  W/ItemListActivity: Tools.randomCube() UUDFURLLRBBRDRRLUFUDDBFFRLUUFBBDRDBLRUFDLDLLBFLFFBRDUB
2019-07-04 21:58:44.951  W/ItemListActivity: kociemba Input UUDFURLLRBBRDRRLUFUDDBFFRLUUFBBDRDBLRUFDLDLLBFLFFBRDUB
2019-07-04 21:58:44.952  W/ItemListActivity: kociemba input vaild
2019-07-04 21:58:44.955  W/twophase.Search: new CoordCube(cc) >
2019-07-04 21:58:44.958  W/twophase.CoordCube: twistMove
2019-07-04 21:58:45.082  W/twophase.CoordCube: flipMove
2019-07-04 21:58:45.194  W/twophase.CoordCube: FRtoBR_Move
2019-07-04 21:58:45.933  W/twophase.CoordCube: URFtoDLF_Move
2019-07-04 21:58:47.087  W/twophase.CoordCube: URtoDF_Move
2019-07-04 21:58:48.324  W/twophase.CoordCube: URtoUL_Move >
2019-07-04 21:58:48.402  W/twophase.CoordCube: URtoUL_Move <
2019-07-04 21:58:48.402  W/twophase.CoordCube: UBtoDF_Move >
2019-07-04 21:58:48.483  W/twophase.CoordCube: UBtoDF_Move <
2019-07-04 21:58:48.484  W/twophase.CoordCube: MergeURtoULandUBtoDF >
2019-07-04 21:58:48.804  W/twophase.CoordCube: MergeURtoULandUBtoDF <
2019-07-04 21:58:48.804  W/twophase.CoordCube: Slice_URFtoDLF_Parity_Prun >
2019-07-04 21:59:06.516  W/twophase.CoordCube: Slice_URFtoDLF_Parity_Prun <
2019-07-04 21:59:06.516  W/twophase.CoordCube: Slice_URtoDF_Parity_Prun >
2019-07-04 21:59:22.950  W/twophase.CoordCube: Slice_URtoDF_Parity_Prun <
2019-07-04 21:59:22.950  W/twophase.CoordCube: Slice_Twist_Prun >
2019-07-04 21:59:43.483  W/twophase.CoordCube: Slice_Twist_Prun <
2019-07-04 21:59:43.483  W/twophase.CoordCube: Slice_Flip_Prun >
2019-07-04 22:00:02.688  W/twophase.CoordCube: Slice_Flip_Prun <
2019-07-04 22:00:02.688  W/twophase.CoordCube: twist
2019-07-04 22:00:02.688  W/twophase.CoordCube: flip
2019-07-04 22:00:02.688  W/twophase.CoordCube: parity
2019-07-04 22:00:02.688  W/twophase.CoordCube: FRtoBR
2019-07-04 22:00:02.688  W/twophase.CoordCube: URFtoDLF
2019-07-04 22:00:02.688  W/twophase.CoordCube: URtoUL
2019-07-04 22:00:02.688  W/twophase.CoordCube: UBtoDF
2019-07-04 22:00:02.688  W/twophase.CoordCube: URtoDF
2019-07-04 22:00:02.688  W/twophase.Search: new CoordCube(cc) <
2019-07-04 22:00:05.984  W/ItemListActivity: kociemba solution = U F' D2 B R' D' L' B R2 U2 R F' D' L2 F2 D' R2 U R2 D' 
2019-07-04 22:00:05.993  W/ItemListActivity: Tools.randomCube() FLDBUULLUBRBBRBLULUURDFDFDBDFDFDBRRUULFFLRFLLRDRRBUBFD
2019-07-04 22:00:05.993  W/ItemListActivity: kociemba Input FLDBUULLUBRBBRBLULUURDFDFDBDFDFDBRRUULFFLRFLLRDRRBUBFD
2019-07-04 22:00:05.994  W/ItemListActivity: kociemba input vaild
2019-07-04 22:00:05.995  W/twophase.Search: new CoordCube(cc) >
2019-07-04 22:00:05.995  W/twophase.CoordCube: twist
2019-07-04 22:00:05.995  W/twophase.CoordCube: flip
2019-07-04 22:00:05.995  W/twophase.CoordCube: parity
2019-07-04 22:00:05.995  W/twophase.CoordCube: FRtoBR
2019-07-04 22:00:05.995  W/twophase.CoordCube: URFtoDLF
2019-07-04 22:00:05.995  W/twophase.CoordCube: URtoUL
2019-07-04 22:00:05.995  W/twophase.CoordCube: UBtoDF
2019-07-04 22:00:05.995  W/twophase.CoordCube: URtoDF
2019-07-04 22:00:05.995  W/twophase.Search: new CoordCube(cc) <
2019-07-04 22:00:07.143  W/ItemListActivity: kociemba solution = R' D2 L2 U L' B R' U' L2 U F' U L2 D B2 U L2 F2 D2 F2 D'
```

生成数据库花了90s,求解才花了2s

Huawei nova2 海思 麒麟 659
2.36GHz（大四核），1.7GHz（小四核）

```
2019-07-04 22:11:02.673 W/ItemListActivity: Tools.randomCube() RBFUUDRFLFFRURDUFUURDUFFDLLFDFLDLLBBBRBBLBBURUDDRBRLLD
2019-07-04 22:11:02.680 W/twophase.Search: new CoordCube(cc) >
2019-07-04 22:11:02.684 W/twophase.CoordCube: twistMove
2019-07-04 22:11:03.014 W/twophase.CoordCube: flipMove
2019-07-04 22:11:03.326 W/twophase.CoordCube: FRtoBR_Move
2019-07-04 22:11:05.304 W/twophase.CoordCube: URFtoDLF_Move
2019-07-04 22:11:08.764 W/twophase.CoordCube: URtoDF_Move
2019-07-04 22:11:12.353 W/twophase.CoordCube: URtoUL_Move >
2019-07-04 22:11:12.571 W/twophase.CoordCube: URtoUL_Move <
2019-07-04 22:11:12.572 W/twophase.CoordCube: UBtoDF_Move >
2019-07-04 22:11:12.792 W/twophase.CoordCube: UBtoDF_Move <
2019-07-04 22:11:12.792 W/twophase.CoordCube: MergeURtoULandUBtoDF >
2019-07-04 22:11:13.847 W/twophase.CoordCube: MergeURtoULandUBtoDF <
2019-07-04 22:11:13.847 W/twophase.CoordCube: Slice_URFtoDLF_Parity_Prun >
2019-07-04 22:13:53.896 W/twophase.CoordCube: Slice_URFtoDLF_Parity_Prun <
2019-07-04 22:13:53.896 W/twophase.CoordCube: Slice_URtoDF_Parity_Prun >
2019-07-04 22:16:24.431 W/twophase.CoordCube: Slice_URtoDF_Parity_Prun <
2019-07-04 22:16:24.431 W/twophase.CoordCube: Slice_Twist_Prun >
2019-07-04 22:19:43.867 W/twophase.CoordCube: Slice_Twist_Prun <
2019-07-04 22:19:43.868 W/twophase.CoordCube: Slice_Flip_Prun >
2019-07-04 22:22:50.488 W/twophase.CoordCube: Slice_Flip_Prun <
2019-07-04 22:22:50.488 W/twophase.CoordCube: twist
2019-07-04 22:22:50.488 W/twophase.CoordCube: flip
2019-07-04 22:22:50.488 W/twophase.CoordCube: parity
2019-07-04 22:22:50.488 W/twophase.CoordCube: FRtoBR
2019-07-04 22:22:50.488 W/twophase.CoordCube: URFtoDLF
2019-07-04 22:22:50.488 W/twophase.CoordCube: URtoUL
2019-07-04 22:22:50.488 W/twophase.CoordCube: UBtoDF
2019-07-04 22:22:50.489 W/twophase.CoordCube: URtoDF
2019-07-04 22:22:50.489 W/twophase.Search: new CoordCube(cc) <
2019-07-04 22:22:51.210 W/ItemListActivity: kociemba solution = U2 L2 F U' L2 U L U' D' R2 F R' D B2 R2 F2 R2 U' F2 B2 L2 U

```
生成数据库11min，求解1s

可见数据库生成占比较大，这一步可以优化。只要初始化完成后就永久保存数据库。

题外话，麒麟 659 真的是被 骁龙710 按在地上摩擦。但华为居然把它优化到可以作为主力机使用，真心佩服。

模块化数据库生成方式后

Mi 8 SE 

```
2019-07-04 22:53:20.636 W/ItemListActivity: Tools.randomCube() DLULURRDFUBLURLBFDUBRFFBDFLLDUDDRLURRFBRLUBLFFUBBBDFRD
2019-07-04 22:53:20.643 W/twophase.Search: new CoordCube(cc) >
2019-07-04 22:53:20.655 W/twophase.CoordCube: creatTwistMove() >
2019-07-04 22:53:20.745 W/twophase.CoordCube: creatTwistMove() <
2019-07-04 22:53:20.745 W/twophase.CoordCube: creatFlipMove() >
2019-07-04 22:53:20.828 W/twophase.CoordCube: creatFlipMove() <
2019-07-04 22:53:20.828 W/twophase.CoordCube: createFRtoBR_Move() >
2019-07-04 22:53:21.358 W/twophase.CoordCube: createFRtoBR_Move() <
2019-07-04 22:53:21.359 W/twophase.CoordCube: creatURFtoDLF_Move() >
2019-07-04 22:53:22.203 W/twophase.CoordCube: creatURFtoDLF_Move() <
2019-07-04 22:53:22.203 W/twophase.CoordCube: creatURtoDF_Move() >
2019-07-04 22:53:23.160 W/twophase.CoordCube: creatURtoDF_Move() <
2019-07-04 22:53:23.160 W/twophase.CoordCube: creatURtoUL_Move() >
2019-07-04 22:53:23.220 W/twophase.CoordCube: creatURtoUL_Move() <
2019-07-04 22:53:23.220 W/twophase.CoordCube: creatUBtoDF_Move() >
2019-07-04 22:53:23.282 W/twophase.CoordCube: creatUBtoDF_Move() <
2019-07-04 22:53:23.283 W/twophase.CoordCube: creatMergeURtoULandUBtoDF() >
2019-07-04 22:53:23.566 W/twophase.CoordCube: creatMergeURtoULandUBtoDF() <
2019-07-04 22:53:23.567 W/twophase.CoordCube: creatSlice_URFtoDLF_Parity_Prun() >
2019-07-04 22:53:24.096 W/twophase.CoordCube: creatSlice_URFtoDLF_Parity_Prun() <
2019-07-04 22:53:24.096 W/twophase.CoordCube: creatSlice_URtoDF_Parity_Prun() >
2019-07-04 22:53:24.589 W/twophase.CoordCube: creatSlice_URtoDF_Parity_Prun() <
2019-07-04 22:53:24.590 W/twophase.CoordCube: creatSlice_Twist_Prun() >
2019-07-04 22:53:25.281 W/twophase.CoordCube: creatSlice_Twist_Prun() <
2019-07-04 22:53:25.282 W/twophase.CoordCube: creatSlice_Flip_Prun() >
2019-07-04 22:53:25.905 W/twophase.CoordCube: creatSlice_Flip_Prun() <
2019-07-04 22:53:25.905 W/twophase.Search: new CoordCube(cc) <
2019-07-04 22:53:26.129 W/ItemListActivity: kociemba solution = L2 D R2 F2 B L2 F' D' L' F' L U' L2 U' F2 R2 L2 D B2 U 
```

生成加求解一共才6s

只是把数据库生成放在了构造函数内就快了这么多？编译器做了优化？很疑惑

果然数学家和工程师的关注点不同

```
2019-07-04 22:58:21.318 W/ItemListActivity: Tools.randomCube() FUUBURUULDDRFRFLFRFBBLFRFLURUBRDDLRDUDLBLDDUDBFRLBLBBF
2019-07-04 22:58:21.326 W/twophase.Search: new CoordCube(cc) >
2019-07-04 22:58:21.354 W/twophase.CoordCube: creatTwistMove() >
2019-07-04 22:58:21.587 W/twophase.CoordCube: creatTwistMove() <
2019-07-04 22:58:21.587 W/twophase.CoordCube: creatFlipMove() >
2019-07-04 22:58:21.809 W/twophase.CoordCube: creatFlipMove() <
2019-07-04 22:58:21.809 W/twophase.CoordCube: createFRtoBR_Move() >
2019-07-04 22:58:23.262 W/twophase.CoordCube: createFRtoBR_Move() <
2019-07-04 22:58:23.262 W/twophase.CoordCube: creatURFtoDLF_Move() >
2019-07-04 22:58:25.709 W/twophase.CoordCube: creatURFtoDLF_Move() <
2019-07-04 22:58:25.709 W/twophase.CoordCube: creatURtoDF_Move() >
2019-07-04 22:58:28.349 W/twophase.CoordCube: creatURtoDF_Move() <
2019-07-04 22:58:28.349 W/twophase.CoordCube: creatURtoUL_Move() >
2019-07-04 22:58:28.511 W/twophase.CoordCube: creatURtoUL_Move() <
2019-07-04 22:58:28.511 W/twophase.CoordCube: creatUBtoDF_Move() >
2019-07-04 22:58:28.674 W/twophase.CoordCube: creatUBtoDF_Move() <
2019-07-04 22:58:28.674 W/twophase.CoordCube: creatMergeURtoULandUBtoDF() >
2019-07-04 22:58:29.535 W/twophase.CoordCube: creatMergeURtoULandUBtoDF() <
2019-07-04 22:58:29.535 W/twophase.CoordCube: creatSlice_URFtoDLF_Parity_Prun() >
2019-07-04 22:58:31.240 W/twophase.CoordCube: creatSlice_URFtoDLF_Parity_Prun() <
2019-07-04 22:58:31.240 W/twophase.CoordCube: creatSlice_URtoDF_Parity_Prun() >
2019-07-04 22:58:32.839 W/twophase.CoordCube: creatSlice_URtoDF_Parity_Prun() <
2019-07-04 22:58:32.839 W/twophase.CoordCube: creatSlice_Twist_Prun() >
2019-07-04 22:58:34.831 W/twophase.CoordCube: creatSlice_Twist_Prun() <
2019-07-04 22:58:34.831 W/twophase.CoordCube: creatSlice_Flip_Prun() >
2019-07-04 22:58:36.699 W/twophase.CoordCube: creatSlice_Flip_Prun() <
2019-07-04 22:58:36.699 W/twophase.Search: new CoordCube(cc) <
2019-07-04 22:58:37.114 W/ItemListActivity: kociemba solution = L F2 B U D2 F' R' D F2 B R B2 L2 U2 L2 D' R2 D R2 B2 D2
```

nova2 才16s！！

这样看来数据库保存至本地的功能可以降低优先级了，哈哈

构造方法变为静态，并判断是否重复构造后

nova2 测试

```
2019-07-04 23:26:13.942 Tools.randomCube() FRUBULFDBRDBBRUDLDLRUUFDLRBFBRUDFDURULUDLRLLDLFRBBFFFB
2019-07-04 23:26:14.168 kociemba solution = U2 D R D L U2 B2 R L2 B' R' D L2 D2 L2 U' R2 L2 U' F2 U 
2019-07-04 23:26:15.408 Tools.randomCube() RDRUUUDFRFBBLRDFDRBLUFFUUBULLLFDFLRFBRLDLUDRBULDRBBDBF
2019-07-04 23:26:15.553 kociemba solution = U2 R B' R D2 F' R' D2 F2 D' F D' R2 F2 L2 D' L2 U' F2 U B2 
2019-07-04 23:26:17.904 Tools.randomCube() LRBRUUFBULFUFRFUDLULBDFLRULDRFDDBDBBFDRULLBFFRBDRBLDUR
2019-07-04 23:26:18.323 kociemba solution = U R2 F' R F2 B' D' F L U' D2 R D2 L2 U R2 U' B2 U2 R2 F2 L2 
2019-07-04 23:26:20.534 Tools.randomCube() FRFFURDFFLUDURFBBLBLULFLBBRRDDRDRDDUUDLULBFFURDRUBBBLL
2019-07-04 23:26:21.485 kociemba solution = R D F R U R B' D' L2 F B2 L' F2 U' R2 L2 F2 D' L2 D B2 R2 
2019-07-04 23:26:23.377 Tools.randomCube() DLLLUUFFUBRFDRFBFURRRDFLDDLLBUUDDDRFRUDBLRLFFUBBLBURBB
2019-07-04 23:26:23.646 kociemba solution = L B U2 R2 U' B' L2 D2 F2 B R' D' L2 F2 D2 F2 U' B2 U' L2 F2 
2019-07-04 23:26:24.615 Tools.randomCube() RRDLUDLULBRFURULBDUBUFFLRFBURDDDRULRBDFLLDFBBLUDFBBFFR
2019-07-04 23:26:24.825 kociemba solution = U' F2 R2 B2 L F L B2 L2 U' B R2 D' L2 F2 B2 D' B2 U R2 U2 
2019-07-04 23:26:25.815 Tools.randomCube() RDDLUFBUDFRLLRRFDFULRBFDBFUDULBDBFDLUFLBLLRRRBRBUBUDFU
2019-07-04 23:26:25.876 kociemba solution = U2 L' U2 R U2 D2 R2 B' D B L2 D' F2 U L2 D L2 B2 L2 U2 
2019-07-04 23:26:26.905 Tools.randomCube() UUBLUUDRBUFUFRRFBLRBLDFDLRLUDDRDURLBRDBLLBFFFRLFUBFDBD
2019-07-04 23:26:27.424 kociemba solution = L2 B U D2 R2 F' R' F B2 U B R2 B2 L2 U2 L2 U R2 D' R2 U2 
2019-07-04 23:26:28.277 Tools.randomCube() ULRLUDUFBRBDRRBLBFFUUFFUDLDBDFDDUDBRLULRLRRFLBFBLBDURF
2019-07-04 23:26:28.916 kociemba solution = U F' R2 U L2 U2 L F' U D B L' U' F2 U' F2 U2 R2 D' F2 U2 R2 
2019-07-04 23:26:29.903 Tools.randomCube() RDDFUFRLULDFLRRLRRDBBBFDUUFBLUUDBLFDFUFFLUBRRLBUDBRBLD
2019-07-04 23:26:30.204 kociemba solution = B2 R B L2 U F R2 U B' L' F B2 D2 B2 D B2 L2 D B2 D' L2 
2019-07-04 23:26:31.058 Tools.randomCube() RFFDULUFFDUDURRULBFRLLFBUDBBBLLDDUDDBFLRLBFFRRUDUBBLRR
2019-07-04 23:26:31.301 kociemba solution = R' D2 B2 L D B U L' B2 U F' D' R2 U' F2 U' R2 F2 L2 U' 
2019-07-04 23:26:32.119 Tools.randomCube() RRUUUBLRRFLRDRFLLBDDUFFBBBDDUFDDFFFLDLBRLRULRBBFUBUUDL
2019-07-04 23:26:32.264 kociemba solution = L2 U' R' U F2 B R U2 D2 F' U2 D F2 D R2 D' F2 B2 L2 U' 
2019-07-04 23:26:33.200 Tools.randomCube() LDLLURRLDFDDBRRDUUUURBFUBBBUDRLDFFUFDDBFLLUFLFFBBBRRRL
2019-07-04 23:26:33.550 kociemba solution = U F U2 R' F D' B L2 D F2 U2 L' U2 R2 L2 U B2 U' D2 F2 R2 U2 
2019-07-04 23:26:33.952 Tools.randomCube() FRULURBFFLURURRFURLDURFBDLLFDDLDFLBDUBDULBUFRBDRFBLBDB
2019-07-04 23:26:34.561 kociemba solution = U B' L2 U' D2 B' R U' B L' U F R2 U R2 D' B2 L2 D L2 F2 D 
2019-07-04 23:26:34.700 Tools.randomCube() UBBDURRBBRBDRRLFUBDLUFFDLURFBUUDRBURFFFLLRLFDLDLFBDDLU
2019-07-04 23:26:35.445 kociemba solution = U F L' F R D2 R2 B L2 D2 F' L U R2 L2 F2 B2 U' F2 R2 F2 D' 
2019-07-04 23:26:35.449 Tools.randomCube() UFDFUBBUFRRBDRULLLRRDFFBFDBDLDLDBRUUFUURLDUFLRRLBBDBLF
2019-07-04 23:26:36.330 kociemba solution = R U' D2 F' L' D' R B' R2 B R F' L2 B2 R2 D2 B2 D' F2 D' L2 D 
2019-07-04 23:26:36.336 Tools.randomCube() RFBBUBUFDFDDDRLLBLRRRFFRBUURRBLDRFLFBUFFLULDULDDUBLUBD
2019-07-04 23:26:36.376 kociemba solution = U F' L B' D' R B2 L2 F2 D F' U' F2 U L2 F2 L2 B2 
2019-07-04 23:26:36.696 Tools.randomCube() ULUBULUFFRFRRRLDRDRUDLFUUFLLRBDDBLDBFUFFLDDRBBBLUBDRBF
2019-07-04 23:26:36.783 kociemba solution = U F' U' R L F2 U2 F2 R2 F' L U2 R2 U2 R2 B2 D R2 B2 U' F2 
2019-07-04 23:26:37.077 Tools.randomCube() FLFFUBRFBURDLRFFBLFDLRFUBFLRLDBDLRUBLUUBLDDDURDURBUDRB
2019-07-04 23:26:38.591 kociemba solution = R D F B R' L' B R' U' D' B2 L' B2 L2 B2 D F2 D2 R2 U' F2 L2 
2019-07-04 23:26:38.597 Tools.randomCube() FULUUBRDDBUDLRUDDUBBLRFFURRLBFRDFBDLULDBLDUFBFFRRBLFLR
2019-07-04 23:26:38.669 kociemba solution = U B D B' L F' R2 L' F U2 L F2 B2 U' F2 R2 F2 R2 D' L2 F2 
2019-07-04 23:26:38.676 Tools.randomCube() BUFDURBURUFRFRFDULDBBFFLLBFURLDDLRBBULRLLUFRFURLDBBDDD
2019-07-04 23:26:38.924 kociemba solution = F U2 B2 L' B R' D B2 R B L' F2 D' L2 F2 U2 L2 B2 U2 R2 U2 
2019-07-04 23:26:38.926 Tools.randomCube() FFLBULDFFDDURRUDUUBDLFFDDLBFBRBDLBUFLDLULLURRBRUBBRRFR
2019-07-04 23:26:39.123 kociemba solution = R' B L F L' D2 B2 R U D B R2 D F2 D B2 R2 U R2 F2 B2 
2019-07-04 23:26:39.126 Tools.randomCube() DDBBUULDRFRLDRFDRDURUUFLDFFBULUDFUFRRLFBLLRBLUBBLBRFDB
2019-07-04 23:26:40.268 kociemba solution = U2 R B2 D' B' D2 R B' R2 F2 U' R' F2 U2 F2 L2 U R2 U2 F2 D F2 
2019-07-04 23:26:40.273 Tools.randomCube() BUBRULFRBLDUFRFLUBLBDFFRDBDFDFUDFUBLDDUULDFRRRLRLBBULR
2019-07-04 23:26:40.627 kociemba solution = U F2 L2 B D' F' R' U' F2 R2 L B U2 L2 D' F2 D2 B2 R2 F2 B2 
2019-07-04 23:26:40.630 Tools.randomCube() LLFFUDDURUFRURBDBDBFBBFRRRFDFLDDLURBULLDLUBLFUUFDBRRBL
2019-07-04 23:26:40.714 kociemba solution = U D L2 U' B' D2 F U' B2 U L U L2 F2 D' L2 U D2 B2 U2 D 
2019-07-04 23:26:40.717 Tools.randomCube() FURDURFRDBBUURLLBLDDLLFRRFUBDBBDUURFRBLULDRLDFFDFBLUFB
2019-07-04 23:26:40.958 kociemba solution = F U' B R2 L B R2 B R2 L B U D2 L2 B2 L2 B2 U R2 B2 U 
```
平均不到1s啊，从目前的情况看来，保存至本地的需求都可以去掉了。

我们只要保证用户拍照的时间比构造数据库时间长就可以了。

而且只是应用重启后的第一次拍照。


## 参考

- [kociemba 1.2.1](https://pypi.org/project/kociemba/)
- [Kociemba算法学习](https://my.oschina.net/goodmoon/blog/1502701)


