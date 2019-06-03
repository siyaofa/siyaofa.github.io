%数字滤波器示例
%

clear;close all;clc;
%超声波传感器采集到的距离数据
%采样周期500ms 单位cm
x=[48.33	48.34	48.33	48.45	48.74	49.17	48.74	48.34	48.34	48.33	48.45	48.34	49.21	48.76	48.34	48.33	48.34	48.45	48.34	49.17	48.71	49.16	48.74	48.71	49.28	48.86	49.17	49.16	48.29	48.29	48.71	49.12	48.81	48.24	48.29];

function y=rc_filter(alpha,x)
  y=x;
  for i=2:length(x)
    y(i)=alpha*x(i)+(1-alpha)*y(i-1);
  endfor
endfunction

%alpha=0.3;
y_2=rc_filter(0.2,x);
y_4=rc_filter(0.4,x);
y_6=rc_filter(0.6,x);
y_8=rc_filter(0.8,x);


%采样周期500ms
sample_period=0.5;
t=sample_period*[1:length(x)];

figure
plot(t,x,t,y_2,t,y_4,t,y_6,t,y_8);
legend('x','y \alpha = 0.2','y \alpha = 0.4','y \alpha = 0.6','y \alpha = 0.8');


%计算一阶滤波器Bode图
figure
fcut=0.6283;%截止频率
RC=1/2/pi/fcut;
pkg load control
y_rc = tf(1,[RC,1]);
bode(y_rc)