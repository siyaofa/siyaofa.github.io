---
layout: page
title: Kociemba Two Phase 算法
date:   2019-10-10
---


## 理论知识

群论

## kociemba主页

>The Two-Phase-Algorithm
The following description is intended to give you a basic idea of how the algorithm works.
The 6 different faces of the Cube are called U(p), D(own), R(ight), L(eft), F(ront) and B(ack). While U denotes an Up Face quarter turn of 90 degrees clockwise, U2 denotes a 180 degrees turn and U' denotes a quarter turn of 90 degrees counter-clockwise. A sequence like U D R' D2 of Cube moves is called a maneuver.
If you turn the faces of a solved cube and do not use the moves R, R', L, L', F, F', B and B' you will only generate a subset of all possible cubes. This subset is denoted by G1 = <U,D,R2,L2,F2,B2>. In this subset, the orientations of the corners and edges cannot be changed. That is, the orientation of an edge or corner at a certain location is always the same. And the four edges in the UD-slice (between the U-face and D-face) stay isolated in that slice.
In phase 1, the algorithm looks for maneuvers which will transform a scrambled cube to G1. That is, the orientations of corners and edges have to be constrained and the edges of the UD-slice have to be transferred into that slice. In this abstract space, a move just transforms a triple (x,y,z) into another triple (x',y',z'). All cubes of G1 have the same triple (x0,y0,z0) and this is the goal state of phase 1.
To find this goal state the program uses a search algorithm which is called iterative deepening A* with a lowerbound heuristic function (IDA*). In the case of the Cube, this means that it iterates through all maneuvers of increasing length. The heuristic function h1(x,y,z) estimates for each cube state (x,y,z) the number of moves that are necessary to reach the goal state. It is essential that the function never overestimates this number. In Cube Explorer 2, it gives the exact number of moves which are necessary to reach the goal state in Phase 1. The heuristic allows pruning while generating the maneuvers, which is essential if you do not want to wait a very, very long time before the goal state is reached. The heuristic function h1 is a memory based lookup table and allows pruning up to 12 moves in advance.
In phase 2 the algorithm restores the cube in the subgroup G1, using only moves of this subgroup. It restores the permutation of the 8 corners, the permutation of the 8 edges of the U-face and D-face and the permutation of the 4 UD-slice edges. The heuristic function h2(a,b,c) only estimates the number of moves that are necessary to reach the goal state, because there are too many different elements in G1.
The algorithm does not stop when a first solution is found but continues to search for shorter solutions by carrying out phase 2 from suboptimal solutions of phase 1. For example, if the first solution has 10 moves in phase 1 followed by 12 moves in phase 2, the second solution could have 11 moves in phase 1 and only 5 moves in phase 2. The length of the phase 1 maneuvers increase and the length of the phase 2 maneuvers decrease. If the phase 2 length reaches zero, the solution is optimal and the algorithm stops.
In the current implementation the Two-Phase-Algorithm does not look for some solutions that are optimal overall, those that must cross into and back out of phase 2. This increases the speed considerably. Use the Optimal Solver, if you want to prove some maneuver to be optimal.

## 大体思路

就三阶魔方而言，其状态空间非常大(超过43,252,003,274,489,856,000)

通过数学证明把魔方状态空间缩小到几个子集

G0 = < L,R,F,B,U,D >
G1 = < U,D,L2,R2,F2,B2 >
G2 = < L2,R2,F2,B2,U2,D2 >

Kociemba主页上说，在G1群内，边和角的方向都不会改变了。一个指定的边或者角，在同一个位置，其方向是固定的。

从G2到还原态就相对简单许多。

不同阶段的搜索算法使用的是IDA*

二阶魔方我直接使用了双向BFS，11步以内就可以搜索到。需要思考为何用IDA*算法搜索。

## 疑问

之前看贴图魔方还原后的状态，发现一个现象。魔方还原后中心块的位置其实是任意状态的。只不过因为很多魔方都是纯色的，可能没有注意到这个问题。


## 参考

- [Kociemba算法学习](https://my.oschina.net/goodmoon/blog/1502701)
- 