---
layout: page
title: Kociemba 主页 翻译
date:   2019-10-11
---

## 目的

为了更好的理解Kociemba二阶算法，遂翻译其主页(非直译)。便于算法理解，后续4阶魔方还原算法参考。

## Facelet层面置换 

三阶魔方共有 6*9=54 个facelets

![](../pic/kociemba_page/还原态facelets.bmp)

一次转动会使得facelets重新排列，我们把这个称之为置换。

U, R, F, D, B, L 代表着对应面顺时针旋转90°;
U2, R2, F2, D2, B2, L2 代表着对应面旋转180°;
U', R', F', D', B', L' 代表着对应面逆时针旋转90°.

F旋转会有如下结果

1. F1移动至F3 (F1-›F3), F2-›F6, F3-›F9, F4-›F2, F5-›F5, F6-›F8, F7-›F1, F8-›F4, F9-›F7.
F1 F2 F3 F4 F5 F6 F7 F8 F9
F3 F6 F9 F2 F5 F8 F1 F4 F7

2. F1被F7替换 (F1‹-F7), F2‹-F4, F3‹-F1, F4‹-F8, F5‹-F5, F6‹-F2, F7‹-F9, F8‹-F6, F9‹-F3. 
F1 F2 F3 F4 F5 F6 F7 F8 F9
F7 F4 F1 F8 F5 F2 F9 F6 F3

(F3,F6,F9,F2,F5,F8,F1,F4,F7)是“移动至”的表示方式
(F7,F4,F1,F8,F5,F2,F9,F6,F3)是“被替换”的表示方式

facelet阶段我们用“移动至”的表示方式，cobie阶段用“被替换”的表示方式。

在移动至的表示方式下，我们定义乘法如下：

F1 F2 F3 F4 F5 F6 F7 F8 F9
F2 F1 F6 F3 F5 F4 F8 F7 F9

\*

F1 F2 F3 F4 F5 F6 F7 F8 F9
F3 F6 F9 F2 F5 F8 F1 F4 F7

=

F1 F2 F3 F4 F5 F6 F7 F8 F9
F6 F3 F8 F9 F5 F2 F4 F1 F7

和普通乘法定义不同的是，置换的乘法不满足交换律。

当然从F和F'的操作结果，我们知道F\*F'=I.

F'就代表F的逆，这种情况下乘法是满足交换律的。

F'\*F=I

F转动的完整的表达

F:=(U1,U2,U3,U4,U5,U6,R1,R4,R7,D3,R2,R3,D2,R5,R6,D1,R8,R9,F3,F6,F9,F2,F5,F8,F1,F4,F7,L3,L6,L9,D4,D5,D6,D7,D8,D9,L1,L2,U9,L4,L5,U8,L7,L8,U7,B1,B2,B3,B4,B5,B6,B7,B8,B9)

因为有些facelet是有固定位置关系的，比如棱和角或者中心面。

所以facelet阶段的表达方式并不是很简洁，这也是为什么有cobie阶段存在。

## Cobie层面置换

这一层面我们置换的对象不再是facelets了，而是12条边和8个角。

12条边：UR, UF, UL, UB, DR ,DF, DL, DB, FR, FL, BL, BR

8个角：URF, UFL, ULB, UBR, DFR, DLF, DBL, DRB

cobie阶段不能仅靠边和角的排列组合表示魔方的状态，因为边和角是有方向的。

在初始位置上，角可以旋转，边也可以翻转。

在这一层面，我们用“被替换”的表达方式，表示一次旋转

同样还是F，URF被UFL替换(URF‹-UFL), UFL‹-DLF, ULB ‹-ULB, UBR‹-UBR,
DFR‹-URF, DLF‹-DFR, DBL ‹-DBL, DRB‹-DRB

可以表示如下：


|URF| UFL| ULB| UBR| DFR |DLF |DBL| DRB|
|--|--|--|--|--|--|--|--|--|
|UFL |DLF |ULB |UBR| URF| DFR| DBL| DRB|

因为角是有方向的

|URF | UFL | ULB| UBR| DFR| DLF| DBL| DRB|
|--|--|--|--|--|--|--|--|--|
|c:UFL;o:1 | c:DLF;o:2 | c:ULB;o:0 | c:UBR;o:0 | c:URF;o:2 | c:DFR;o:1 | c:DBL;o:0 | c:DRB,o:0 |

0:未旋转；1：顺时针旋转；2：逆时针旋转
如果有两个旋转是2+2=4，4对3取模得1，表示是一个顺时针旋转。

边也可以用类似的方式表示
0：未翻转；1：翻转

F用公式可以如下表示

F(URF).c = UFL
F(URF).o = 1
F(UFL).c = DLF
F(UFL).o = 2
...

R =
|URF| UFL| ULB |UBR| DFR |DLF| DBL| DRB|
|--|--|--|--|--|--|--|--|--|
|c:DFR;o:2| c:UFL;o:0| c:ULB;o:0| c:URF;o:1 |c:DRB;o:1| c:DLF;o:0 |c:DBL;o:0 |c:UBR,o:2|

F\*R 

F(URF).c = UFL and F(URF).o = 1
R(UBR).c = URF and R(UBR).o= 1

F：URF‹-UFL ,R: UBR‹-URF, 所以F\*R的结果是 UBR‹-UFL. 
(F*R)(UBR).c = UFL. 
(F*R)(UBR).c = F(R(UBR).c).c.

方向的变换稍微复杂些

(F*R)(UBR).o=F(R(UBR).c).o+R(UBR).o.

任意位置x处，A\*B 有：
(A\*B)(x).c=A(B(x).c).c
and
(A\*B)(x).o=A(B(x).c).o+B(x).o

>If we want also want to include the case of reflections, which we need if we apply symmetries of the cube, thing are a bit more complicated with the orientations of the corners. Instead of adding modulo 3 in the second equation above, which can be interpreted as a group operation in the cyclic group C3, we then work in the dihedral group D3. We describe the three extra elements in this group with the numbers 3, 4, and 5.

## Coordinate 层面置换

我们用自然数表示对边和角的状态，即对边和角的状态进行编码。

### 角的方向编码

R

|URF| UFL| ULB |UBR| DFR |DLF| DBL| DRB|
|--|--|--|--|--|--|--|--|--|
|c:DFR;o:2| c:UFL;o:0| c:ULB;o:0| c:URF;o:1 |c:DRB;o:1| c:DLF;o:0 |c:DBL;o:0 |c:UBR,o:2|

0 - 2186 (3^7 - 1).

`2*3^6 + 0*3^5 + 0*3^4 + 1*3^3 +1*3^2 + 0*3^1 + 0*3^0 = 1494`

其实就是把3进制2001100用十进制1494表示。

为什么不算DRB呢？因为可由7个角的方向确定最后一个方向。

### 边的方向编码

12 条边的表示范围 0 - 2047 (2^11 - 1)

### 角的位置编码

0 - 40319 (8! - 1).

|URF| UFL| ULB |UBR| DFR |DLF| DBL| DRB|
|--|--|--|--|--|--|--|--|--|
|c:DFR;o:2| c:UFL;o:0| c:ULB;o:0| c:URF;o:1 |c:DRB;o:1| c:DLF;o:0 |c:DBL;o:0 |c:UBR,o:2|
||1| 1| 3| 0| 1| 1| 4|

人为指定角的顺序 `URF<UFL<ULB<UBR<DFR<DLF<DBL<DRB`

最后一行代表第二行中左边序号大于当前的个数

c:URF左侧的DRF,UFL,ULB都比URF大，所以是3

c:UBR左侧的DRF,DRB,DLF,DBL比UBR大，所以是4

`1*1! + 1*2! + 3*3! + 0*4! + 1*5! + 1*6! + 4*7! = 21021`

### 边位置编码

类似的方式可知，编码范围 0 - (12! - 1)

### 总的状态数

魔方的状态可根据边角的位置、方向共同决定

`(3^7) * (2^11) * (8!) * (12!)`

因为有奇偶性，所以要除2

`3^7 * 2^11 * 8! *12! /2 = 43,252,003,274,489,856,000`

暴力穷举基本不用想了

## 等效和对称

## 陪集

群G和其子群H，群G中每个g，设{a\*g| a in H}为H的右陪集。

|G的子群 |陪集坐标| 使用阶段|
|--|--|--|
|所有角的方向都为0 |角方向范围 0..2186 | 阶段1|
|所有边的方向都为0|边方向范围 0..2047|阶段1|
|UD中间层四个边都在中间层|UDSlice范围0..493|阶段1
|边方向为0且UD-slice的四条边都在中间层|FlipUDSlice范围 0..494*2048 - 1|阶段1|
|所有角都在对应位置，角可以旋转|范围 0..40319|阶段2|
|U、D两层的边都在对应位置，边可以翻转|阶段2边的范围 0..40319|阶段2|
|UDSlice的四条边都在对应位置，可翻转|排序后的范围 0..11879|阶段2|

上面有些坐标会因为冗余而被剔除，后面章节会做说明。

根据角的方向定义子群 `C0 = { g | G中所有角x的方向 g(x).o = 0 }`

其右陪集定义

`C0*g = {a*g | a in C0}`

根据前面的定义

`(a*g)(x).o = a(g(x).c).o + g(x).o = 0 + g(x).o = g(x).o  `

说明右陪集`C0*g`中有相同的角方向坐标，也就是右陪集中所有元素的角方向是相同的。如果两个状态的角方向坐标相同，就认为在同一个右陪集内（证明略）。所以角方向坐标和右陪集C0是一一对应的。


## 坐标和对称

没看明白……
只知道根据对称形式，坐标范围可以降低


## 二阶算法

定义群`G1 = <U,D,R2,L2,F2,B2>.`

这个群内，所有角的方向和边的方向都为0.并且UDSlice的四条边都在UDSlice内。

换句话说，只要所有边、角的方向都为0，并且UDSlice的边在UDSlice内，我们就到达了G1.

第一阶段，我们从打乱状态搜索到G1的路径，并记录到达G1时的状态，这个状态将在第二阶段用上。

我们会尝试在阶段1搜索最短路径。

第一阶段，魔方的状态是由

1. 角的方向(`0..2186`)
2. 边的方向(`0..2047`)
3. UDSlice的四条边(`0.. 494 (12*11*10*9/4! - 1`),12选4的组合不考虑顺序)

所组成

阶段1的状态空间大小为 `2187*2048*495 = 2,217,093,120`

22亿状态，好像也不小啊

第二阶段，魔方状态由：

1. 角的排列(`0..40319(8!-1)`)
2. 边的排列(`0..40319(8!-1)`)
3. UDSilce四条边排列(`4!=24`)

阶段2的状态空间大小为`40320*40320*24/2 = 19,508,428,800`



## 转动表

也可以称之为状态迁移表，第一维代表当前状态，第二位代表转动

直接通过查表可知下一个状态，加快搜索速度。

`TwistMove: array[0..2187-1,Ux1..Bx3]`

TODO 对称冗余

一共需要三个查找表

SymMove, MoveTable, SymMult

## 裁剪表

Two-Phase 搜索算法速度取决于搜索时给出的最少还原步数。
(译者注:使用的是IDA* 算法，IDA* 的核心是启发函数, 魔方还原算法的启发函数就是给出最少还原步数)

我们在初始化的时候其实已知最小的还原步数,保存每个状态对应的最小还原步数。这样可以动态对搜索路径进行裁剪，加快搜索速度。

|裁剪表|对称坐标|原始坐标|表长度|最大裁剪深度|
|--|--|--|--|--|
|阶段1|FlipUDSlice(64430类等效)|UDTwist(2187情况)|140,908,410 |12|
|阶段2|角排列(2768类等效)|边的排列(40320情况) |111,605,760| 18|
|最优还原|UDSliceSorted(788类等效)|边翻转(2048)角旋转(2187)|3,529,433,088| 13|

## 二阶算法详情

受Thistlethwaite算法启发，Kociemba为了缩短最少还原步骤，减少了过程中子群的数目。

1. 对状态进行编码,使用查找表
2. 保留状态到还原态的距离(即IDA*中的启发函数)

阶段1最多需要12步，阶段2最多需要18步。所以搜索出的第一个解最多只有30步。

Kociemba自己都不敢相信，最后的效果如此之好。大多数只要22步就能还原。

Mike Reid于1997年使用了对称去冗余，改善效果很明显。于是Kociemba也使用了这个方法。

Two-Phase算法在搜索到第一个解的时候并不会停止，它会尝试搜索更短的解。

比如，阶段1步长为10，阶段2长度为12.那么可能获得第二个解，阶段1长度为11，阶段2长度为5. 通常来说第二阶段长度会急剧下降(通常小于9)。

## 最优解

Mike Reid于1997年提出此方法。阶段1同时在三个不同的方向上搜索。最后的结果是

- <U,D,R2,L2,F2,B2>
- <U2,D2,R,L,F2,B2>
- <U2,D2,R2,L2,F,B>

的交集。(译者：直观上来说这很合理，最开始看算法简介时，我也没理解为何`G1=<U,D,R2,L2,F2,B2>` 后续Kociemba也没有解释。果然三个方向终点的群是不同的)

这个交集并不是`<U2,D2,R2,L2,F2,B2>`, 而是一个大小为6倍于G2的群。

## 对称模板



