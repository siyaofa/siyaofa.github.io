clear;close all;clc;

jerk=1;
acc=0.4;
vel=0.1;%100mm/s
dist=1;%1m

%总时间t
total_time=dist/vel+vel/acc+acc/jerk;

sample_period=0.001;%采样周期1ms

time=sample_period*[0:total_time];

t=zeros(7,1);
t(1)=acc/jerk;
t(2)=vel/acc;
t(3)=vel/acc+acc/jerk;
t(4)=dist/vel;
t(5)=dist/vel+acc/jerk;
t(6)=dist/vel+vel/acc;
t(7)=dist/vel+vel/acc+acc/jerk;

jerk_t=time;
acc_t=time;
vel_t=time;
s_t=time;
