---
layout: page
title: arduino uno 测距
---

<!---
版本    日期    作者    描述
v1.0    2019.06.01  lous    文件创建

-->

# 使用 Arduino Uno 和超神波传感器测距

实物图

![image](../pic/arduino_sonar.jpg)

超神波传感器模块解析数据源码如下

```c
/*
  www.openjumper.com
  日期:2013.5.18
  IDE 版本:1.0.1
  功能：利用SR04超声波传感器进行测距，并用串口显示测出的距离值
*/

// 设定SR04连接的Arduino引脚
const int TrigPin = 2;
const int EchoPin = 3;
float distance;
void setup()
{ 
  // 初始化串口通信及连接SR04的引脚
  Serial.begin(9600);
  pinMode(TrigPin, OUTPUT);
  // 要检测引脚上输入的脉冲宽度，需要先设置为输入状态
  pinMode(EchoPin, INPUT);
  Serial.println("Ultrasonic sensor:");
}
void loop()
{
  // 产生一个10us的高脉冲去触发TrigPin
  digitalWrite(TrigPin, LOW);
  delayMicroseconds(2);
  digitalWrite(TrigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(TrigPin, LOW);
  // 检测脉冲宽度，并计算出距离
  distance = pulseIn(EchoPin, HIGH) / 58.00;
  Serial.print(distance);
  //Serial.print("cm");
  Serial.println();
  delay(500);
}

```

通过接收Pin脚高电平持续的时间计算实际物理距离
```c
distance = pulseIn(EchoPin, HIGH) / 58.00;//单位cm
```

在超神波和被测物体未发生相对位移时

终端串口打印出的输入如下

48.33	48.34	48.33	48.45	48.74	49.17	48.74	48.34	48.34	48.33	48.45	48.34	49.21	48.76	48.34	48.33	48.34	48.45	48.34	49.17	48.71	49.16	48.74	48.71	49.28	48.86	49.17	49.16	48.29	48.29	48.71	49.12	48.81	48.24	48.29	

采样周期可近似为500ms，采样周期即2Hz。

采集到的原始数据需要滤波后才可以使用。