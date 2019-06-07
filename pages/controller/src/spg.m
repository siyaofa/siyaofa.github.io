clear;close all;clc;

jerk=4;
acc=0.4;
vel=0.1;%100mm/s
dist=1;%1m

%总时间t
total_time=dist/vel+vel/acc+acc/jerk;

sample_period=0.001;%采样周期1ms

time=0:sample_period:total_time;

t=zeros(7,1);
t(1)=acc/jerk;
t(2)=vel/acc;
t(3)=vel/acc+acc/jerk;
t(4)=dist/vel;
t(5)=dist/vel+acc/jerk;
t(6)=dist/vel+vel/acc;
t(7)=dist/vel+vel/acc+acc/jerk;

t_int=t/sample_period;

jerk_t=zeros(size(time));
acc_t=zeros(size(time));
vel_t=zeros(size(time));
s_t=zeros(size(time));


acc_t(1:t_int(1))=jerk*time(1:t_int(1));
acc_t(t_int(1):t_int(2))=acc;
acc_t(t_int(2):t_int(3))=acc-jerk*(time(t_int(2):t_int(3))-t(2));


figure
plot(time,acc_t);
