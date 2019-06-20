function dst = quaternion_rotate(src,axis,theta)
% lous quaternion_rotate - rotate a 3-D point src
% around axis theta radian
%
% Syntax: dst = quaternion_rotate(src,axis,theta)
%
% 

pkg load quaternion
theta=theta/2;
p_src=quaternion (0,src(1),src(2),src(3));
q=quaternion(cos(theta),sin(theta)*axis(1),sin(theta)*axis(2),sin(theta)*axis(3));
qinv = inv (q);
p_dst=(q.*p_src).*qinv;
dst=[p_dst.x,p_dst.y,p_dst.z];

% % p_src=[0,src];
% p_src=quaternion ([0,src])
% q=quaternion([cos(theta),sin(theta)*axis]);
% %qinv = inv (q);
% q_converse=quaternion([cos(theta),-sin(theta)*axis])/abs(q);

% %q*p_src*q_converse;
% %p_dst=quatmultiply(q,p_src);
% %p_dst=quatmultiply(p_dst,q_converse);
% p_dst=q.*p_sr.*q_converse;
% dst=p_dst(2:end);
    
end

function c=quatmultiply(a,b)
c=a;
end