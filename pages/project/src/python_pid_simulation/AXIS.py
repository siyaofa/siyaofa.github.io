#!/usr/bin/python
# -*- coding:utf-8 -*-
# 2018-11-13 23：27 lous
# 仿真轴，可在此处实现模拟的传递函数
# =====================================

class AXIS:
    
    def __init__(self,pos,mass,sample_period):
        #速度 m/s
        self.velocity=0.0
        #位置 m
        self.act_pos=pos
        #加速度 m/s^2
        self.acceleration=0.0
        #质量kg
        self.mass=mass
        #力 N
        self.force=0.0
        #时间 s
        self.sample_period=sample_period

    #给指定大小的力
    def set_force(self,value):
        self.force=value
        self.acceleration=self.force/self.mass
    
    def get_pos(self):
        delta_time = self.sample_period
        delta_displacement = self.velocity*delta_time+0.5*self.acceleration*delta_time**2
        self.velocity+=self.acceleration*delta_time
        self.act_pos+=delta_displacement
        return self.act_pos
