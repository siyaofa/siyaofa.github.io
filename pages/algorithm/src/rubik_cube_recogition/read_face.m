function [img, hue, saturation, value] = read_face(filename,face_size)
    pkg load image
    img = imread(filename);
    scale=1;
    img=imresize(img,[face_size face_size]);
    img = imsmooth(img, "Gaussian");
    hsv_map = rgb2hsv(img);
    hue = hsv_map(:, :, 1);
    saturation = hsv_map(:, :, 2);
    value = hsv_map(:, :, 3);
end

%{
img = F;
scal = 0.1;
T = [1, 0, 0; 0, 1, 0; 0, 0, 1];
tT = T .* scal;
tT(3, 3) = 1;
flag = sign(scal);
[x, y, z] = size(img);
tx = floor(x * scal);
ty = floor(y * scal);
Image = zeros(tx, ty);

for i = 1:tx

    for j = 1:ty
        temp = floor((tT^-1) * [i; j; 1]);
        Image(i, j) = img(temp(1), temp(2));
        end;
        end;
        %}
