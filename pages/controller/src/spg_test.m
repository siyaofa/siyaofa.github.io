clear;close all;clc;

jerk=4;
acc=0.4;
vel=0.1;%100mm/s
dist=-0.3;%1m

sample_period=0.001;%采样周期1ms

[t,acc,vel,shift,switch_time]=spg(sample_period,jerk,acc,vel,dist);

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