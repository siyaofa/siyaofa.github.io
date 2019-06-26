clear; close all; clc;

file_path = '../../pic/rubik_cube_facelet/';
filenames = {'U_cut', 'F_cut', 'D_cut', 'R_cut', 'B_cut', 'L_cut'};
ext = '.jpg';
save_path = 'pic/';

saturation_weight = 0.95;
sv_thresh = 0.75;
black_value_thresh = 0.3;

hue_map = [];
saturation_map = [];
value_map = [];

for i = 1:6
    filename = filenames{i};
    [img, hue, saturation, value] = read_face([file_path filename ext]);
    hue_map = [hue_map; hue(:)];
    saturation_map = [saturation_map; saturation(:)];
    value_map = [value_map; value(:)];

    imwrite(hue, [save_path filename '_hue.jpg']);
    imwrite(saturation, [save_path filename '_saturation.jpg']);
    imwrite(value, [save_path filename '_value.jpg']);
    
%{
 figure(1)
    subplot(4, 6, i); imshow(img);
    set(gca, 'LooseInset', get(gca, 'TightInset'))
    subplot(4, 6, 6 + i); imshow(hue);
    subplot(4, 6, 12 + i); imshow(saturation);
    subplot(4, 6, 18 + i); imshow(value);

    figure(2)
    subplot(4, 6, i); imshow(value > black_value_thresh);
    sv = (1 - saturation_weight) * value + saturation_weight * (1 - saturation);
    subplot(4, 6, 6 + i); imshow(sv > sv_thresh);
    h_no_bw_mask = (sv < sv_thresh) .* (value > black_value_thresh);
    subplot(4, 6, 12 + i); imshow(h_no_bw_mask);
    clear img_color;

    for j = 1:3
        img_color(:, :, j) = img(:, :, j) .* h_no_bw_mask;
    end

    subplot(4, 6, 18 + i); imshow(img_color); 
%}

    disp(i)
    %{
    figure
    scatter(sin(hue(:)) .* saturation(:), cos(hue(:)) .* saturation(:), 'filled');
    %}

end

%{
figure
title('Raw')
imshow(img)

figure
title('Hue')
imshow(hue)

figure
title('Saturation')
imshow(saturation)

figure
title('Value')
imshow(value)

figure
%scatter3(sin(hue(:)).*saturation(:),cos(hue(:)).*saturation(:),value(:),'filled');
scatter(sin(hue(:)) .* saturation(:),
cos(hue(:)) .* saturation(:), 'filled');
%}

sv_mask = ((1 - saturation_weight) * value_map + saturation_weight * (1 - saturation_map)) <= sv_thresh;
value_mask = value_map >= black_value_thresh;
color_mask=sv_mask.*value_mask;


%{
 figure
scatter(sin(2*pi*hue_map(:)) .* saturation_map(:).*color_mask,
cos(2*pi*hue_map(:)) .* saturation_map(:).*color_mask, 'filled');
 
%}


%{
 pkg load statistics
%k-means data
saturation_color=ones(size(hue_color));
data=[cos(2*pi*hue_color).*saturation_color,sin(2*pi*hue_color).*saturation_color];
figure
scatter(data(:,1),data(:,2), 'filled');
[IDX, CENTERS, SUMD, DIST]=kmeans(data,5,'DISTANCE', 'sqeuclidean');
figure
plot(IDX); 
%}

hue_color=hue_map(color_mask>0);
saturation_color=saturation_map(color_mask>0);
figure
bin_num=100000;
hue_hist=hist(hue_color,bin_num)/size(hue_color,1);
hue_axis=(1:size(hue_hist,2))/bin_num;
subplot(211);plot(hue_axis,hue_hist);
hue_shift=0.3*bin_num;
hue_hist_shift=hue_hist;
hue_hist_shift=[hue_hist(hue_shift+1:end),hue_hist(1:hue_shift)];
subplot(212);plot(hue_axis,hue_hist_shift);


hue_hist_sum=hue_hist_shift;
hue_sum_window=0.05*bin_num;
for i=1:size(hue_hist_shift,2)-hue_sum_window+1
hue_hist_sum(i)=sum(hue_hist_shift(i:i+hue_sum_window-1));
end

figure
plot(hue_axis,hue_hist_sum);
hue_shift=0.2;
hue_color_shift=hue_color+hue_shift;
hue_color_shift=hue_color_shift-ones(size(hue_color)).*(hue_color_shift>1);
hue_color_pair=[hue_color,hue_color_shift];

%%%%%%%%%%%%%


figure
bin_num=100000;
hue_axis=(1:size(hue_hist,2))/bin_num;

hue_hist=hist(hue_color,bin_num)/size(hue_color,1);
subplot(211);plot(hue_axis,hue_hist);

hue_hist_shift=hist(hue_color_shift+5,bin_num)/size(hue_color_shift,1);
subplot(212);plot(hue_axis,hue_hist_shift);





GMDIST = fitgmdist (hue_color,5)
GMDIST = fitgmdist (hue_color_shift,5)



#### Generate a two-cluster problem
##C1 = randn (10000,1)*3 + 200;
##C2 = randn (10000,1)*4 - 50;
##data = [C1; C2];
##
#### Perform clustering
##GMModel = fitgmdist (C2, 1)

figure(5)
t=1:100;
hist(hue_color_shift,10000);
