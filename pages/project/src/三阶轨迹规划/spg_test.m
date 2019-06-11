clear;close all;clc;

%加加速度 m/s^3
jerk=4;
%加速度 m/s^2
acc=0.4;
%速度 m/s
vel=0.1;
%距离 m
dist=-0.3;
%采样周期 s
sample_period=0.001;

[t,acc,vel,shift,switch_time]=spg(sample_period,jerk,acc,vel,dist);

%绘图
figure
subplot(311);
plot(t,acc);
ylim([(max(acc)+min(acc))*0.5-(max(acc)-min(acc))*0.6,
 (max(acc)+min(acc))*0.5+(max(acc)-min(acc))*0.6]);
xlim([0 t(end)]);
title("Accelaration");
ylabel('m/s^2')

subplot(312);
plot(t,vel);
ylim([(max(vel)+min(vel))*0.5-(max(vel)-min(vel))*0.6,
 (max(vel)+min(vel))*0.5+(max(vel)-min(vel))*0.6]);
xlim([0 t(end)]);
title("Velocity");
ylabel('m/s')

subplot(313);
plot(t,shift);
ylim([(max(shift)+min(shift))*0.5-(max(shift)-min(shift))*0.6,
 (max(shift)+min(shift))*0.5+(max(shift)-min(shift))*0.6]);
xlim([0 t(end)]);
title("Shift");
ylabel('m')
xlabel('s')