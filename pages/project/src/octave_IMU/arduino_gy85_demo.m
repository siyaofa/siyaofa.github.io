close all;clear;clc;

sample_num=5000;

#静止状态下采磁力计和陀螺仪数据
[acc_data,gyro_data,compass_data] = gy85_sample(sample_num);

gyro_offset= mean(gyro_data,1);
compass_offset= mean(compass_data,1);

save gyro_data gyro_data gyro_offset;
save compass_data compass_data compass_offset;

figure
scatter3(acc_data(:,1),acc_data(:,2),acc_data(:,3))
title('acc')

figure
scatter3(gyro_data(:,1),gyro_data(:,2),gyro_data(:,3),'.')
title('gyro')

figure
scatter3(compass_data(:,1),compass_data(:,2),compass_data(:,3),'.')
title('compass')

#慢慢旋转传感器采集加速度数据
sample_num=10000;
[acc_data,gyro_data,compass_data] = gy85_sample(sample_num);

# load 'acc_data'
# save acc_data acc_data;


figure
scatter3(acc_data(:,1),acc_data(:,2),acc_data(:,3))
title('acc')

pkg load optim
g=9.8;

f=@(p,data)((data(:,1)-p(1))/p(2)).^2 ...
+ ((data(:,2)-p(3))/p(4)).^2 ...
+ ((data(:,3)-p(5))/p(6)).^2 -g^2;

## 拟合求得加速度偏心 各轴比例系数
p=nlinfit(acc_data,zeros(size(acc_data,1),1),f,[0 1 0 1 0 1]);
#保存数据
acc_offset=p;
save acc_data acc_offset acc_data;

acc_calibration=[(acc_data(:,1)-p(1))/p(2),(acc_data(:,2)-p(3))/p(4),((acc_data(:,3)-p(5))/p(6))];

figure
scatter3(acc_calibration(:,1),acc_calibration(:,2),acc_calibration(:,3))
title('acc calibration')

