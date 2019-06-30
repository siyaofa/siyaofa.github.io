clear; close all; clc;

image_flag=2;

if(image_flag==1)
file_path = '../../pic/rubik_cube_facelet/';
filenames = {'U_cut', 'F_cut', 'D_cut', 'R_cut', 'B_cut', 'L_cut'};
elseif(image_flag=2)
file_path = 'pic/20190628/';
filenames = {'U', 'F', 'D', 'R', 'B', 'L'};
else
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% global parameter that maybe use in every step
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
facelet_pixel_num = 100;
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
%show_gray_hsv(image_map,gray_map,hue_map,saturation_map,value_map);

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

edge_gray_thresh=facelet_gray_average;

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
subplot(211);imshow(flip_value_map_mean);
subplot(212);imshow(im2bw(flip_value_map_mean,edge_gray_thresh));
figure
hist(flip_value_map_mean(:),10)
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
figure
hist(flip_sg_map_mean(:),10)
else

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% try to find white region
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure

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
    subplot(4, 6, 12 + i); imshow(im2bw(saturation_gray,white_sg_thresh));
    facelets=facelet_mean(saturation_gray,center_size);
    sg_facelets(:,:,i)=facelets;
end

white_sg_thresh=0;
sg_sort=sort(sg_facelets(:));
white_sg_thresh=(sg_sort(end-9)+sg_sort(end-8))/2;

for i=1:6
  
    white_facelet=im2bw(sg_facelets(:,:,i),white_sg_thresh);
    subplot(4, 6, 18 + i);imshow(white_facelet);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% hist of gray and hsv
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
show_gray_hsv_hist(image_map,gray_map,hue_map,saturation_map,value_map);



%%%%%%%%%%%%%%%%%%%%
figure
h_no_bw_mask_map = zeros(3 * facelet_pixel_num, 3 * facelet_pixel_num, 6);
img_color = img;

for i = 1:6

    img = image_map{i};
    hue = hue_map(:, :, i);
    saturation = saturation_map(:, :, i);
    value = value_map(:, :, i);

    subplot(4, 6, i); imshow(value > black_value_thresh);
    sv = (1 - saturation_weight) * value + saturation_weight * (1 - saturation);
    subplot(4, 6, 6 + i); imshow(sv > sv_thresh);
    h_no_bw_mask = (sv < sv_thresh) .* (value > black_value_thresh);
    h_no_bw_mask_map(:, :, i) = h_no_bw_mask;
    subplot(4, 6, 12 + i); imshow(h_no_bw_mask);

    for j = 1:3
        img_color(:, :, j) = img(:, :, j) .* h_no_bw_mask;
    end

    subplot(4, 6, 18 + i); imshow(img_color);

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% get color mask - no black or white
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
h_no_bw_mask_erode_map = h_no_bw_mask_map;
h_no_bw_mask_open_map = h_no_bw_mask_map;
color_mask_close_times = 15;
se1 = strel('disk', color_mask_close_times, 0);

for i = 1:6
    h_no_bw_mask_open_map(:, :, i) = bwmorph(h_no_bw_mask_map(:, :, i), 'open', 30);
    h_no_bw_mask_erode_map(:, :, i) = imerode(h_no_bw_mask_open_map(:, :, i), se1);
    h_no_bw_mask_erode_map(:, :, i) = bwmorph(h_no_bw_mask_erode_map(:, :, i), 'dilate', color_mask_close_times);
    subplot(4, 6, i); imshow(h_no_bw_mask_map(:, :, i));
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
% calculate hue hist of color pixels
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hue_color = hue_map(h_no_bw_mask_erode_map > 0);
saturation_color = saturation_map(h_no_bw_mask_erode_map > 0);

bin_num = 1000;
hue_hist = hist(hue_color, bin_num) / size(hue_color, 1);
hue_axis = (1:size(hue_hist, 2)) / bin_num;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% calculate percentage of hue in a window width=0.1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hue_hist_sum = hue_hist;
hue_hist_sigma = hue_hist;
hue_half_window = 0.05 * bin_num;
hue_in_window = zeros(1, 2 * hue_half_window + 1);

for i = 1:length(hue_hist)

    if (i < hue_half_window + 1)
        hue_in_window = [hue_hist(end - hue_half_window + i:end), hue_hist(1:i + hue_half_window)];
    elseif (i > (length(hue_hist) - hue_half_window))
        hue_in_window = [hue_hist(i - hue_half_window:end), hue_hist(1:i + hue_half_window - length(hue_hist))];
    else
        hue_in_window = hue_hist(i - hue_half_window:i + hue_half_window);
    end

    hue_hist_sum(i) = sum(hue_in_window);
end

hue_half_window = 0.02 * bin_num;

for i = 1:length(hue_hist_sum)

    if (i < hue_half_window + 1)
        hue_in_window = [hue_hist_sum(end - hue_half_window + i:end), hue_hist_sum(1:i + hue_half_window)];
    elseif (i > (length(hue_hist_sum) - hue_half_window))
        hue_in_window = [hue_hist_sum(i - hue_half_window:end), hue_hist_sum(1:i + hue_half_window - length(hue_hist_sum))];
    else
        hue_in_window = hue_hist_sum(i - hue_half_window:i + hue_half_window);
    end

    hue_hist_sigma(i) = std(hue_in_window);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% calculate hue_hist_sum hue_hist_sigma
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hue_sigma_thresh = 0.005;
hue_percentage_thresh = 0.1;
hue_hist_sum_valid_mask = (abs(hue_hist_sum - 0.2) < hue_percentage_thresh) .* (hue_hist_sigma < hue_sigma_thresh);
hue_hist_sum_valid = hue_hist_sum(hue_hist_sum_valid_mask > 0.5);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% hist sum sigma hue hist we want
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
subplot(411); plot(hue_axis, hue_hist);
subplot(412); plot(hue_axis, hue_hist_sum);
subplot(413); plot(hue_axis, hue_hist_sigma);
subplot(414); plot(hue_axis, hue_hist_sum .* hue_hist_sum_valid_mask);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% calculate hue of each color
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[color_label, color_num] = bwlabel(hue_hist_sum_valid_mask, 4);

for i = 1:color_num
    hue_color_mean(i) = mean(hue_axis(color_label == i));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% show the color that we recognition
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hue_map_calibrated = hue_map;
saturation_map_calibrated = saturation_map;
value_map_calibrated = value_map;
color_color_labeled_mask_map = zeros(3 * facelet_pixel_num, 3 * facelet_pixel_num, 6);

for i = 1:color_num
    color_labeled_mask = abs(hue_map_calibrated - hue_color_mean(i)) < 0.05;
    color_color_labeled_mask_map = color_color_labeled_mask_map + color_labeled_mask;
    hue_map_calibrated(color_labeled_mask) = hue_color_mean(i);
    saturation_map_calibrated(color_labeled_mask) = mean(saturation_map_calibrated(color_labeled_mask)(:));
    value_map_calibrated(color_labeled_mask) = mean(value_map_calibrated(color_labeled_mask)(:));
end

hsv = rgb2hsv(img);
re_img = img;
figure

for i = 1:6
    hsv(:, :, 1) = hue_map_calibrated(:, :, i);
    hsv(:, :, 2) = saturation_map_calibrated(:, :, i);
    hsv(:, :, 3) = value_map_calibrated(:, :, i);
    re_img = hsv2rgb(hsv);

    for j = 1:3
        re_img(:, :, j) = re_img(:, :, j) .* h_no_bw_mask_erode_map(:, :, i);
        %img(:, :, j)=image_map{i} .* h_no_bw_mask_erode_map(:,:,i);
    end

    subplot(2, 6, i); imshow(image_map{i});
    subplot(2, 6, 6 + i); imshow(re_img .* color_color_labeled_mask_map(:, :, i));
end

%%%%%%%%%%%%%

%figure
%bin_num = 100000;
%hue_axis = (1:size(hue_hist, 2)) / bin_num;
%
%hue_hist = hist(hue_color, bin_num) / size(hue_color, 1);
%subplot(211); plot(hue_axis, hue_hist);
%
%hue_hist_shift = hist(hue_color_shift + 5, bin_num) / size(hue_color_shift, 1);
%subplot(212); plot(hue_axis, hue_hist_shift);
%
%pkg load statistics;
%GMDIST = fitgmdist(hue_color, 5);
%GMDIST = fitgmdist(hue_color_shift, 5);

%% Generate a two - cluster problem
%C1 = randn(10000, 1) * 3 + 200;
%C2 = randn(10000, 1) * 4 - 50;
%data = [C1; C2];
%
%% Perform clustering
%GMModel = fitgmdist(C2, 1)
