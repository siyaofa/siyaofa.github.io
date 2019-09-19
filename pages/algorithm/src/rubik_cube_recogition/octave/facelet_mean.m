function [facelets]=facelet_mean(img,center_size)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% calc the facelet center average of a single image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
face_size=size(img,1);
facelet_size=face_size/3;
facelet_valid_center_size=center_size*facelet_size;

for i=1:3
  for j=1:3
    leftup=(i-0.5)*facelet_size-0.5*facelet_valid_center_size;
    leftdown=(i-0.5)*facelet_size+0.5*facelet_valid_center_size;
    rightup=(j-0.5)*facelet_size-0.5*facelet_valid_center_size;
    rightdown=(j-0.5)*facelet_size+0.5*facelet_valid_center_size;
    facelet_center=img(leftup:leftdown, rightup:rightdown);
    facelets(i,j)=mean(facelet_center(:));
  end
end
end
