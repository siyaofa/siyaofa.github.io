clear; close all; clc;

image_flag=4;

if(image_flag==1)
file_path = '../../pic/rubik_cube_facelet/';
filenames = {'U_cut', 'F_cut', 'D_cut', 'R_cut', 'B_cut', 'L_cut'};
elseif(image_flag==2)
file_path = 'pic/20190628/';
filenames = {'U', 'F', 'D', 'R', 'B', 'L'};
elseif(image_flag==3)
file_path = 'pic\Anroid\Rubik Cube Pictures\';
filenames = {'Up.png', 'Front.png', 'Down.png', 'Right.png', 'Back.png', 'Left.png'};
elseif(image_flag==4)
%file_path = 'pic\Anroid\Rubik Cube Pictures\201907040032\';
file_path = 'pic\Anroid\Rubik Cube Pictures\201907071942\';
filenames = {'Up.png', 'Front.png', 'Down.png', 'Right.png', 'Back.png', 'Left.png'};
else
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% global parameter that maybe use in every step
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
facelet_pixel_num = 60;
edge_color=-1;%0-black 1-white
saturation_weight = 0.95;
sv_thresh = 0.5;
black_value_thresh = 0.15;
facelet_percentage=0.8;%1 for 100%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% load image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
save_jpg=0;
[image_map,gray_map,hue_map,saturation_map,value_map]=load_images(
file_path,filenames,facelet_pixel_num,save_jpg);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% show rgb and hue saturation value of image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
show_gray_hsv(image_map,gray_map,hue_map,saturation_map,value_map);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% show mean gray of image, calc gray flip 
% this step is trying to estimate the edge gray value 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

center_size=0.5;
[flip_gray_map_mean,face,facelets] = facelet_center_mean(gray_map,center_size);
facelet_gray_average=mean(facelets(:));
disp('face gray mean');
disp(face);
disp('facelets center gray');
disp(facelets);
disp('facelets center gray average');
disp(facelet_gray_average);

if(face<mean(facelets(:)))
disp('the edge color maybe black');
edge_color=0;
else
disp('the edge color maybe white');
edge_color=1;
end

edge_gray_thresh=face;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% show mean value of image
% this step is trying to estimate the value channel thresh
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

center_size=0.5;
[flip_value_map_mean,value_average,facelets] = facelet_center_mean(value_map,center_size);
disp('value mean');
disp(value_average);
disp('facelets center value');
disp(facelets);

sg_map=(1-saturation_map).*flip_gray_map_mean;
[flip_sg_map_mean,sg_average,facelets] = facelet_center_mean(sg_map,center_size);
disp('(1-saturation)*gray');
disp(sg_average);
disp('facelets center (1-saturation)*gray');
disp(facelets);

if(sg_average<mean(facelets(:)))
sg_average=mean(facelets(:));
end


if(edge_color==0)

figure
subplot(211);imshow(flip_gray_map_mean);
flip_black_mask=1-im2bw(flip_gray_map_mean,edge_gray_thresh);
edge_gray_thresh
edge_gray_thresh=sum(sum(flip_gray_map_mean.*flip_black_mask))/sum(flip_black_mask(:));

subplot(212);imshow(flip_black_mask);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% show mean saturation of image, calc saturation flip 
% this step is trying to estimate the edge saturation value 
% try to find out whether the edge is white
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elseif(edge_color==1)

center_size=0.5;
[flip_saturation_map_mean,saturation_average,facelets] = facelet_center_mean(saturation_map,center_size);
facelet_saturation_average=mean(facelets(:));
disp('saturation_mean_value');
disp(saturation_average);
disp('facelets center saturation ');
disp(facelets);
disp('facelets center saturation average');
disp(facelet_saturation_average);

figure
subplot(211);imshow(flip_sg_map_mean);
subplot(212);imshow(im2bw(flip_sg_map_mean,sg_average));

else

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% try to find black region black-0 light -1 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
black_mask_map = ones(3 * facelet_pixel_num, 3 * facelet_pixel_num, 6);

if(edge_color==0)
figure
for i=1:6
subplot(3,6,i);imshow(image_map{i});
black_mask_map(:,:,i)=im2bw(gray_map(:,:,i),edge_gray_thresh);
subplot(3,6,6+i);imshow(gray_map(:,:,i));
subplot(3,6,12+i);imshow(black_mask_map(:,:,i));
end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% try to find white region
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
white_mask_map = ones(3 * facelet_pixel_num, 3 * facelet_pixel_num, 6);
white_facelets=zeros(3,3,6);
sg_facelets=zeros(3,3,6);
for i = 1:6
    img = image_map{i};
    hue = hue_map(:, :, i);
    saturation = saturation_map(:, :, i);
    value = value_map(:, :, i);
    gray = gray_map(:, :, i);
    subplot(4, 6, i); imshow(img);
    saturation_gray=(1-saturation).*gray;
    subplot(4, 6, 6 + i); imshow(saturation_gray);

    facelets=facelet_mean(saturation_gray,center_size);
    sg_facelets(:,:,i)=facelets;
end

white_sg_thresh=0;
sg_sort=sort(sg_facelets(:));
white_sg_thresh=(sg_sort(end-9)+sg_sort(end-8))/2;

for i=1:6
    saturation = saturation_map(:, :, i);  
    gray = gray_map(:, :, i);
    saturation_gray=(1-saturation).*gray;
    white_mask_map(:,:,i)=im2bw(saturation_gray,white_sg_thresh);
    subplot(4, 6, 12 + i); imshow( white_mask_map(:,:,i));
    white_facelet=im2bw(sg_facelets(:,:,i),white_sg_thresh);
    white_facelets(:,:,i)=white_facelet;
    subplot(4, 6, 18 + i);imshow(white_facelet);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% after we got white black mask ,we have the color mask 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
color_mask_map=black_mask_map.*(1-white_mask_map);
%figure
%for i=1:6
%subplot(2,6,i);imshow(image_map{i});
%subplot(2,6,6+i);imshow(color_mask_map(:,:,i));  
%end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% hist of gray and hsv
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%show_gray_hsv_hist(image_map,gray_map,hue_map,saturation_map,value_map);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% get color mask - no black or white
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
h_no_bw_mask_erode_map = color_mask_map;
h_no_bw_mask_open_map = h_no_bw_mask_erode_map;
color_mask_close_times = 15;
se1 = strel('disk', color_mask_close_times, 0);

for i = 1:6
    h_no_bw_mask_open_map(:, :, i) = bwmorph(color_mask_map(:, :, i), 'open', 30);
    h_no_bw_mask_erode_map(:, :, i) = imerode(h_no_bw_mask_open_map(:, :, i), se1);
    h_no_bw_mask_erode_map(:, :, i) = bwmorph(h_no_bw_mask_erode_map(:, :, i), 'dilate', color_mask_close_times);
    subplot(4, 6, i); imshow(color_mask_map(:, :, i));
    subplot(4, 6, 6 + i); imshow(h_no_bw_mask_open_map(:, :, i));
    subplot(4, 6, 12 + i); imshow(h_no_bw_mask_erode_map(:, :, i));
    img = image_map{i};

    for j = 1:3
        img_color(:, :, j) = img(:, :, j) .* h_no_bw_mask_erode_map(:, :, i);
    end

    subplot(4, 6, 18 + i); imshow(img_color);
end

%%%%%%%%%%%%%%%%%%%%
%sv_mask = ((1 - saturation_weight) * value_map + saturation_weight * (1 - saturation_map)) <= sv_thresh;
%value_mask = value_map >= black_value_thresh;
%color_mask = sv_mask .* value_mask;

%{
figure
scatter(sin(2 * pi * hue_map(:)) .* saturation_map(:) .* color_mask,
cos(2 * pi * hue_map(:)) .* saturation_map(:) .* color_mask, 'filled');

%}

%{
pkg load statistics
%k-means data
saturation_color = ones(size(hue_color));
data = [cos(2 * pi * hue_color) .* saturation_color, sin(2 * pi * hue_color) .* saturation_color];
figure
scatter(data(:, 1), data(:, 2), 'filled');
[IDX, CENTERS, SUMD, DIST] = kmeans(data, 5, 'DISTANCE', 'sqeuclidean');
figure
plot(IDX);
%}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% calculate average hue in every facelet 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
center_size=0.5;
hue_facelets=zeros(3,3,6);
for i=1:6
hue_facelets(:,:,i)=facelet_mean(hue_map(:,:,i),center_size);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% try to guess the hue value of one color
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% white can't be calc again, only color be in statistic
color_hue_values=sort(hue_facelets(white_facelets==0));
figure
subplot(121);bar(color_hue_values);
%shift 
color_hue_values_shift_over=color_hue_values+0.2;
color_hue_values_shift_over(color_hue_values_shift_over>1)=color_hue_values_shift_over(color_hue_values_shift_over>1)-1;
subplot(122);bar(sort(color_hue_values_shift_over));
%subplot(223);bar(sort(hue_map(color_mask_map==1)));

hue_ext=[color_hue_values;color_hue_values(1:9)];

err=zeros(9,5);
hue_average=zeros(9,5);
for i=1:9
  shift_hue=hue_ext(i:i+44);
  for j=1:5
    err(i,j)=std(shift_hue(9*j-8:9*j))^2;
    hue_average(i,j)=mean(shift_hue(9*j-8:9*j));
  end
end

[min_value,min_index]=min(mean(err,2));
hue_center=hue_average(min_index,:);
disp('hue center value')
disp(hue_center)

for i=1:6
facelet_label_map(:,:,i)=get_hue_label(hue_facelets(:,:,i),hue_center);
end

facelet_label_map(white_facelets==1)=1;


for i=1:6
disp(filenames{i})
disp(facelet_label_map(:,:,i))
end

to_kociemba_input(facelet_label_map)