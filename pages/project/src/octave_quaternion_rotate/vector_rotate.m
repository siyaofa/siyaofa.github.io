function dst = vector_rotate(src, axis, theta)
    %myFun - Description
    %
    % Syntax: output = myFun(input)
    %
    % Long description
    r=axis/norm(axis);
    p=src;
    dst=cos(theta)*p+(1-cos(theta))*(p*r')*r+sin(theta)*cross(r,p)
end
