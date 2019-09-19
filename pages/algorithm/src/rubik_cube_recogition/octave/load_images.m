function [image_map,gray_map,hue_map,saturation_map,value_map]=load_images(file_path,filenames,facelet_pixel_num,save_jpg)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% load image
% gray [0~1]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
  
%ext = '.png';
ext = '';
save_path = 'pic/';
  
  image_map = cell(6, 1);
  hue_map = zeros(3 * facelet_pixel_num, 3 * facelet_pixel_num, 6);
saturation_map = zeros(3 * facelet_pixel_num, 3 * facelet_pixel_num, 6);
value_map = zeros(3 * facelet_pixel_num, 3 * facelet_pixel_num, 6);
gray_map = zeros(3 * facelet_pixel_num, 3 * facelet_pixel_num, 6);

  
  
  for i = 1:6
    filename = filenames{i};
    [img, hue, saturation, value] = read_face([file_path filename ext], 3 * facelet_pixel_num);
    image_map{i} = img;
    gray = rgb2gray(img);
    hue_map(:, :, i) = hue;
    saturation_map(:, :, i) = saturation;
    value_map(:, :, i) = value;
    gray_map(:, :, i) = double(gray) / 255;
    if(save_jpg)
    imwrite(hue, [save_path filename '_hue.jpg']);
    imwrite(saturation, [save_path filename '_saturation.jpg']);
    imwrite(value, [save_path filename '_value.jpg']);
    end
    
end
  
  
end
