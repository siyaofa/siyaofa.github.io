function [t,acc,vel,shift,switch_time]=spg(sp,jerk,max_acc,max_vel,distance)
%运动方向
direction=sign(distance);
%加速度曲线分段的边界
time=zeros(7,1);
t_jerk=abs(max_acc/jerk);
t_acc=abs(max_vel/max_acc);
t_vel=abs(distance/max_acc);
time(1)=t_jerk;
time(2)=t_acc;
time(3)=t_jerk+t_acc;
time(4)=t_vel;
time(5)=t_vel+t_jerk;
time(6)=t_vel+t_acc;
time(7)=t_vel+t_acc+t_jerk;
switch_time=time;
%根据采样周期和运动总时间计算出的时间轴
t=0:sp:time(7)*1.2;
%加速度分段表达式
acc=jerk*t.*(t>=0 & t<time(1)) ...
+max_acc.*(t>=time(1) & t<time(2)) ...
+(max_acc-jerk*(t-time(2))).*(t>=time(2) & t< time(3)) ...
+0.*(t>=time(3) & t<time(4)) ...
+(-jerk*(t-time(4))).*(t>=time(4) & t<time(5)) ...
+(-max_acc).*(t>=time(5) & t<time(6)) ...
+(-max_acc+jerk*(t-time(6))).*(t>=time(6) & t<=time(7));
%增加加速方向
acc=direction*acc;

%加速度积分求速度
vel=zeros(size(t));
for i=1:length(t)
vel(i)=sum(acc(1:i));
end
vel=vel*sp;

%速度积分求加速度
shift=zeros(size(t));
for i=1:length(t)
shift(i)=sum(vel(1:i));
end
shift=shift*sp;