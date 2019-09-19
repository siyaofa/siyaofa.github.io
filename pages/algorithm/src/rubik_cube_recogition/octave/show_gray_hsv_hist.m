function show_gray_hsv_hist(image_map,gray_map,hue_map,saturation_map,value_map)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% hist of gray and hsv
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%figure
%hist_bin = 10;
%for i = 1:6
%  img = image_map{i};
%  gray = gray_map(:, :, i);
%  hue = hue_map(:, :, i);
%  saturation = saturation_map(:, :, i);
%  value = value_map(:, :, i);
%
%  subplot(4, 6, 0 + i); hist(gray(:), hist_bin);
%  subplot(4, 6, 6 + i); hist(hue(:), hist_bin);
%  subplot(4, 6, 12 + i); hist(saturation(:), hist_bin);
%  subplot(4, 6, 18 + i); hist(value(:), hist_bin);
%
%end 

figure
value_gray_map = value_map .* gray_map;
saturation_gray_map = (1-saturation_map) .* gray_map;
subplot(211); hist(gray_map(:), 10);
subplot(212); hist(saturation_gray_map(:), 10);

end
