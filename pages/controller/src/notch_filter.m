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

omega_n=zero_omega;
notch=tf([1 0 omega_n^2],[1 2*omega_n omega_n^2]);
figure
bode(notch)