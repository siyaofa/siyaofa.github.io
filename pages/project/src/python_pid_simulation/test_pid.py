#!/usr/bin/python
# -*- coding:utf-8 -*-

import random
import PID
import matplotlib.pyplot as plt
from matplotlib import animation
import numpy as np
from scipy.interpolate import spline
import AXIS

# 读取setpoint数据
def read_setpoint(filename):
    f=open(filename)
    setpoint_list=f.readlines()
    data=[]
    for str in setpoint_list:
        data.append(float(str))
    return data

act_pos_list = []
time_list = []
setpoint_list = read_setpoint("setpoint_data.txt")
error_list=[]

def clear_history_data():
    del act_pos_list[:]
    del time_list[:]
    del error_list[:]
    
sample_period=0.001

result_str="  act_pos\tsetpoint\t    time\t    voice\t  output\t   error"
#假设PID输出为力
#PID的输入为位置
def test_pid(P = 0.2,  I = 0.0, D= 0.0):
    pid = PID.PID(P, I, D, sample_period)
    axis = AXIS.AXIS(0,1,sample_period)
    act_pos = 0
    error=0
    global result_str
    global setpoint_list
    i=0
    for value in setpoint_list:
        #实际位置为轴的位置
        act_pos=axis.get_pos()
        pid.update(act_pos)
        output = pid.output
        #给轴加力
        error=pid.last_error
        error_list.append(error)
        #给力加随机误差
        voice=gen_voice(0.05*abs(output))
        axis.set_force(output + voice)
        pid.SetPoint = value
        act_pos=axis.get_pos()
        act_pos_list.append(act_pos)
        i+=1
        time_list.append(i*sample_period)
        #保存数据
        result_str="%s\n%8.4f\t%8.4f\t%f\t%8.5f\t%f\t%f"%(result_str,act_pos,pid.SetPoint,i*sample_period,voice,output,error)

    
def save_result():
    f=open("result.log",'w')
    global result_str
    f.write(result_str)
    f.close()
    

def plot_error(fig_name,title):
    plt.ion()
    ax=plt.subplot()
    ax.plot(time_list, error_list)
    ax.set_xlim((0, time_list[-1]))
    ax.set_ylim((min(error_list)*1.1, max(error_list)*1.1))
    ax.set_xlabel('time (s)')
    ax.set_ylabel('error ')
    ax.set_title(title)
    im=ax.grid(True)
    ims.append(im)
    fig.savefig(fig_name,dpi=100)
    plt.show()
    plt.pause(0.5)
    fig.clf()
    #plt.close(fig)

    
def gen_voice(mag):
    return random.random()*mag-mag/2.0

def update_fig():
    clear_history_data()
    test_pid(kp, ki, kd)
    pass

if __name__ == "__main__":
    kp=5000
    ki=1
    kd=20
    fig=plt.figure()
    ims=[]
    #for kd in range(1,10,1):
        #for ki in range(1,15,5):
        # for kd in range(90,95,1):
    clear_history_data()
    test_pid(kp, ki, kd)
    print("kp = %f , ki = %f , kd = %f , max_error = %f"%(kp,ki,kd,max(error_list)))
    #save_result()
    # plot_result(500)
    fig_name="result_pics/"+"error_kp_%f_ki_%f_kd_%f.jpg"%(kp,ki,kd)
    title='kp=%f, ki=%f, kd=%f'%(kp,ki,kd)
    plot_error(fig_name,title)
        
    #anim = animation.FuncAnimation(fig, ims)
    #anim.save("auto_pid.gif",writer='pillow')
