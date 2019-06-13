%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%SMEE 陷波器
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;close all;clc;
zero_freq=50;
zero_omega=2*pi*zero_freq;
zero_damp=0.01;
pole_freq=50;
pole_omega=2*pi*pole_freq;
pole_damp=0.2;

pkg load control

s = tf('s')
notch=tf([zero_omega^2 2*zero_omega*zero_damp 1],
[pole_omega^2 2*pole_omega*pole_damp 1]);
figure
bode(notch)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%NYU 陷波器
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;close all;clc;
pkg load control
%抑制频率为50Hz
f_n=50;
omega_n=2*pi*f_n;
notch=tf([1 0 omega_n^2],[1 2*omega_n omega_n^2]);
figure
bode(notch)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%带阻尼的陷波器
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;close all;clc;
pkg load control
%抑制频率为50Hz
f_n=50;
%阻尼系数
damping=3;
omega_n=2*pi*f_n;
notch=tf([1 2*omega_n omega_n^2],[1 2*damping*omega_n omega_n^2]);
figure
bode(notch)

