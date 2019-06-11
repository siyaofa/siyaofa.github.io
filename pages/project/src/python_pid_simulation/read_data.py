#!/usr/bin/python
# -*- coding:utf-8 -*-

# 读取setpoint数据
def read_setpoint(filename):
	f=open(filename)
	setpoint_list=f.readlines()
	data=[]
	for str in setpoint_list:
		data.append(float(str))
	return data
	
setpoint_list=read_setpoint("setpoint_data.txt")
print(setpoint_list)