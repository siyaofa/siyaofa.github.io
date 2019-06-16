clear ;close all; clc;

load 'sonar.txt'

R=std(sonar);%测量噪声
Q=std(sonar);%过程噪声
A=1;
B=1;
H=1;

z=sonar(1:400);%观测值
u=zeros(size(z));%输入值
K=zeros(size(z));%卡尔曼增益
t=1:length(z);

figure(1)
filename = 'kalman_filter_R_change.gif'; 

for i=1:10
Q=std(sonar);%过程噪声
R=std(sonar)*i;
[x,K]=kalman_filter(z,u,A,B,R,Q,H);
plot(t,z,t,x);
legend('measurement','kalman filtered')
title(['Q=' ,num2str(Q),' R=',num2str(R)])
drawnow
frame = getframe(1);
im = frame2im(frame);
[imind,cm] = rgb2ind(im);

if i == 1;
imwrite(imind,cm,filename,'gif', 'Loopcount',inf,'DelayTime',1);
else
imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',1);
end

end

close all;

figure(1)
filename = 'kalman_filter_Q_change.gif'; 

for i=1:10
R=std(sonar);%测量噪声
Q=std(sonar)/i;
[x,K]=kalman_filter(z,u,A,B,R,Q,H);
plot(t,z,t,x);
legend('measurement','kalman filtered')
title(['Q=' ,num2str(Q),' R=',num2str(R)])
drawnow
frame = getframe(1);
im = frame2im(frame);
[imind,cm] = rgb2ind(im);

if i == 1;
imwrite(imind,cm,filename,'gif', 'Loopcount',inf,'DelayTime',1);
else
imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',1);
end

end

close all;