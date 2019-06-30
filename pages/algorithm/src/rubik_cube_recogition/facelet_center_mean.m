function [flip_img,face,facelets] = facelet_center_mean(img_map,center_size)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% this function is calculate 6 face ,facelet_mean only calc 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
face_size=size(img_map,1);
facelet_size=face_size/3;
facelet_valid_center_size=center_size*facelet_size;
img=mean( img_map,3);
flip_img=0.5*img+0.25*flipdim(img,1)+0.25*flipdim(img,2);
face=mean(flip_img(:));

for i=1:3
  for j=1:3
    facelet_center=flip_img((i-0.5)*facelet_size-0.5*facelet_valid_center_size:(i-0.5)*facelet_size+0.5*facelet_valid_center_size, ...
    (j-0.5)*facelet_size-0.5*facelet_valid_center_size:(j-0.5)*facelet_size+0.5*facelet_valid_center_size);
    facelets(i,j)=mean(facelet_center(:));
  end
end

end
