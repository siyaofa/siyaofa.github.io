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
f_cut=0.2;%截止频率
RC=1/2/pi/f_cut;
pkg load control
lpf = tf(1,[RC 1]);
bode(lpf);


lpf(x-mean(x))
alpha=2*pi*sample_period*f_cut;
x_rc_filtered=lsim(lpf,x,t);
x_rc_filtered(1:10)=x(1:10);
y_lpf=rc_filter(alpha,x);

figure
plot(t,y_lpf,t,x_rc_filtered,t,x)
legend('y_lpf','x_rc_filtered','x')

%根据传函作bode图
pkg load control
figure
TF=tf([1],[1 1]);
bode(TF);


20*log10(sqrt(1/2))

pkg load symbolic
syms s;
Lf=1/(s+1);
f=ilaplace(Lf);
figure
subplot(121);ezplot(Lf);
subplot(122);ezplot(f);