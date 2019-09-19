function  show_gray_hsv(image_map,gray_map,hue_map,saturation_map,value_map)
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% show rgb and hue saturation value of image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure

for i = 1:6

    img = image_map{i};
    gray = gray_map(:, :, i);
    hue = hue_map(:, :, i);
    saturation = saturation_map(:, :, i);
    value = value_map(:, :, i);

    subplot(5, 6, i); imshow(img);
    subplot(5, 6, 6 + i); imshow(gray);
    subplot(5, 6, 12 + i); imshow(hue);
    subplot(5, 6, 18 + i); imshow(saturation);
    subplot(5, 6, 24 + i); imshow(value);

end
  
end
