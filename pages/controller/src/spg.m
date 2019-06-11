function [t,acc,vel,shift,switch_time]=spg(sp,jerk,max_acc,max_vel,distance)

direction=sign(distance);
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

t=0:sp:time(7)*1.2;

acc=jerk*t.*(t>=0 & t<time(1)) ...
+max_acc.*(t>=time(1) & t<time(2)) ...
+(max_acc-jerk*(t-time(2))).*(t>=time(2) & t< time(3)) ...
+0.*(t>=time(3) & t<time(4)) ...
+(-jerk*(t-time(4))).*(t>=time(4) & t<time(5)) ...
+(-max_acc).*(t>=time(5) & t<time(6)) ...
+(-max_acc+jerk*(t-time(6))).*(t>=time(6) & t<=time(7));

acc=direction*acc;

vel=zeros(size(t));

for i=1:length(t)
vel(i)=sum(acc(1:i));
end
vel=vel*sp;


shift=zeros(size(t));

for i=1:length(t)
shift(i)=sum(vel(1:i));
end
shift=shift*sp;