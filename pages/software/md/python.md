---
layout: page
title: Python
date:   2019-12-23
---

## Python

虽然经常会用到Python，也写过小规模的项目。但是对Python这门语言未形成一个成体系化的理解。

考虑到未来会有一个较大规模的项目需要设计开发，故计划重新学习Python。

目前的理解：

Python作为一种动态语言其开发周期较短，且有大量的第三方库，无需重复造轮子。

在无软硬件环境约束的情况下，建议使用Python。

考虑到生产环境的限制，不能直接从Python 3.x开始。对Python2.x也需要有较深的了解。

Python脚本在运行之前会被编译成字节码，字节码再在虚拟机上运行。

关于字节码在虚拟机上的工作原理，个人觉得现阶段暂时不要考虑。

重点应该关注：

- Python的语法
  不是简单的if else 赋值 循环
  应该涉及到内存这个层面，否则很难精进
  是否存在深拷贝和浅拷贝之类的概念
  垃圾回收如何实现
  内置模块的熟练使用

- 大型项目中的
  模块是如何依赖，导入导出
  为何如此设计
  大型项目中应该关注到哪些点和面

- 混合语言开发
  这部分接触的比较多，稍微了解下就可以了


## Python解释器

主要有CPython IPython PyPy Jython IronPython

暂时只关注官方的CPython

## 命令行交互

我们可以直接启动Python 2.6.9 从老版本开始测试把

```python
Python 2.6.9 |Continuum Analytics, Inc.| (unknown, Jan  9 2015, 10:34:13) [MSC v.1500 64 bit (AMD64)] on win32
Type "help", "copyright", "credits" or "license" for more information.
>>> a=1
>>> b=2
>>> a*b
2
>>>
```

python解释器已经开始运行，虚拟机启动了

我们此时单步操作就是在单步在虚拟机上运行

和linux上的Shell非常相似，通过Shell操作内核函数

## 函数

Python 没有C/C++ 的声明的概念

其实也对，在执行代码时，我们只要保证之前有加载需要调用的函数就可以了

`import`时被调用的函数被编译成字节码`.pyc`文件，这些实现应该就已经被载入内存了

我们调用函数时从前面开始找应该就能找到其实现

### 函数定义

```python
def func(arg):
    '''
    doc
    '''
    pass
```

定义一个函数，python的语句块由源码的缩进表示(真心无力吐槽)。

难不成靠缩进就能把语法树的主要部分就确定下来了？不是没有可能，这样层级关系应该很好处理，不对直接报错……

没有具体实现可以直接加个`pass`保证语法的完整性。

不需要显示声明返回值的类型。

C++应该也可以不要，毕竟链接时返回值类型都不能参与定义函数标识符

### 默认参数

```python 
def func(A,B=b,C=c):
    pass
```

显示调用可以不用考虑参数列表顺序

```python
func(A=a,C=c,B=b)
```
参数列表应该保存了参数名，不像C只保存参数的空间大小

可变量作为默认值会有意想不到的Bug

### 变长参数列表

```python
def func(*arg):
    pass
```
其中`*arg`变成了一个tuple，按需提取


`*args`是可变参数，args接收的是一个tuple；

`**kw`是关键字参数，kw接收的是一个dict。

## 高级特性


### 迭代

for 类似java中的foreach

python写循环几乎可以没有角标

```
>>> from collections import Iterable
>>> isinstance([1,2,3], Iterable) # list是否可迭代
True
```
判断是否可以迭代

这样推断，所有的可迭代类型应该都是继承Iterable的

## 生成器

动态产生需要的对象

节约内存，需要对象的时候再取出

```python
g = (x * x for x in range(10))
>>> g
<generator object <genexpr> at 0x0000000002566EE8>
```
能看到g为一个对象，有地址的

通过`next()`获取下一个对象，没有对象时会抛出一个异常`StopIteration`

generator有个yield关键字

配合for关键字使用，非常的优雅

## 函数式编程

### 高阶函数

类似C类的函数指针，函数作为对象被传递

函数对象可以被修改，修改完后可能没法直接恢复，对于内置的函数谨慎操作

### map和reduce

python的map是一个函数`map()`

`map(func,L)`

对L内的所有元素做一个func操作，并返回操作后的L

类似广播 `f(L)`

`reduce()`很类似，不过执行过程会保存中间数据

`func(func(L0,L1),L2)...`的过程

### filter

`filter(func,L)`

其中`func`是一个返回值为Boolean类型的函数，这样就可以把L中不满足条件的元素滤掉

### sorted

`sorted(L,func)`

```python
def func(a,b):
    if a<b:
        return -1
    elif a==b:
        return 0
    else:
        return 1
```

### lambda

`f = lambda x: x * x`

匿名函数

### 装饰器

终于知道`@`关键字是干啥的了，之前在tensorflow里看到这个关键字时很懵逼

在不改变原函数定义的情况下，动态修改函数定义，返回一个新的函数作为被调用的对象

在重构时作用应该非常大

### 偏函数

```python
>>> import functools
>>> int2 = functools.partial(int, base=2)
```
锁定函数的默认值


## 模块

一个`.py`文件就是一个模块，一个文件夹是一个包，文件夹下得有个`__init__.py`文件，否则这个文件夹就是一个普通的路径。包可以嵌套。

### 作用域

`__func__`名命一般有特殊用途例如
`__doc__ __main__ __init__`

`_func __func`一般为私有变量，不建议外部使用




## 参考

-[Python 2.7教程](https://www.liaoxuefeng.com/wiki/897692888725344/897693568201440)


