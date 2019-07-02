---
layout: page
title: Java
date:   2019-07-02
---

开发Android应用不可避免的需要学习Java。

花了一天时间大概了解了Java的基本语法，发现有C++的基础入门很快。

## TODO

java 简介
实现机理
基本语法


## Java

下载JDK后，参考《Head First Java(第2版)中文版》写了两个简单的Demo。

应该可以开始Android的开发了

```java
import java.util.Date;
import java.io.*;
import javax.swing.*;

public class HelloWorld{

    public private static void main(Strin[] args) {
        System.out.println("Hello World!");
    }
}
```

万能Hello World

Dog类

```java
public class Dog{
    String breed;
    int age;
    String color;
    String name;

    static int count=0;

    Dog(String DogName)
    {
        name=DogName;
        System.out.println("we have "+(++count)+"dogs");
    }

    void barking(){
        System.out.println(name+" barking");
    }
    void hungry(){
        System.out.println(name+" hungry");
    }
    void sleeping(){
        System.out.println(name+" sleeping");
    }
 
}
```