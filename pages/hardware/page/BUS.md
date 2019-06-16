---
layout: page
title: 总线
---

为扩展设备功能经常会使用到总线

## PCI

之前开发自制图像采集卡时接触到PCI总线，吞吐量大且应用范围较广。

Peripheral Component Interconnect

局部总线的标准,允许地址复用。数据可以达到100Mb/s以上

优点：总线结构简单、成本低。

缺点也：并行总线无法连接太多设备，总线扩展性比较差，线间干扰将导致系统无法正常工作。

可以通过PCI桥接芯片扩展PCI接口外设。

一般操作系统在上电时就会识别硬件，并根据不同的硬件信息把外设抽象成一个拓扑结构。存在内核中的拓扑结构能够被应用程序所调用并对相应的PCI外设接口操作。

## VME

军工行业应用较为广泛。目前主流的控制器对外开发功能时，会使用到总线传输命令和数据。


## I2C

相对于PCI和VME，I2C总线传输速率较低，因此对实时性要求高且数据吞吐量较大的场景I2C可能并不是一个很好的选择。

I2C（Inter-Integrated Circuit）为飞利浦双向二线制同步串行总线。一条数据线SDA，一条时钟线SCL。SDA传输数据是大端传输，每次传输一字节。总线上每个设备都有自己的一个addr，共7个bit，广播地址全0.

[TI I2C 介绍](http://www.ti.com/lit/an/slva704/slva704.pdf)

### Arduino I2C

Master

```c
#include <Wire.h>

void setup() {
  Wire.begin();        // join i2c bus (address optional for master)
  Serial.begin(9600);  // start serial for output
}

void loop() {
  Wire.requestFrom(8, 6);    // request 6 bytes from slave device #8

  while (Wire.available()) { // slave may send less than requested
    char c = Wire.read(); // receive a byte as character
    Serial.print(c);         // print the character
  }

  delay(500);
}
```

Slave

```c
#include <Wire.h>

void setup() {
  Wire.begin(8);                // join i2c bus with address #8
  Wire.onRequest(requestEvent); // register event
}

void loop() {
  delay(100);
}

// function that executes whenever data is requested by master
// this function is registered as an event, see setup()
void requestEvent() {
  Wire.write("hello "); // respond with message of 6 bytes
  // as expected by master
}
```