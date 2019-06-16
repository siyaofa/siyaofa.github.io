function [x_posteriori,K]=kalman_filter(z,u,A,B,R,Q,H)
%z-观测值 u-输入值 R-测量噪声 Q-过程噪声 H-观测矩阵
%

p_priori=zeros(size(z));%预测误差协方差
p_posteriori=zeros(size(z));%估计误差协方差
K=zeros(size(z));%卡尔曼增益
x_priori=z;%预测值
x_posteriori=z;%估计值

for k=2:length(z)
  
  x_priori(k)=A*x_posteriori(k-1)+B*u(k);
  p_priori(k)=A*p_posteriori(k-1)*A'+Q;
  
  K(k)=p_priori(k)*H'*inv(H*p_priori(k)*H'+R);
  x_posteriori(k)=x_priori(k)+K(k)*(z(k)-H*x_priori(k));
  p_posteriori(k)= (1-K(k)*H)*p_priori(k);
  
end
