function label=get_hue_label(value,hue_thresh)
  for i=1:size(value,1)
    for j=1:size(value,2)
      dist=abs(hue_thresh-value(i,j));
      dist(dist>0.5)=1-dist(dist>0.5);
      [~,label(i,j)]=min(dist); 
end 
end
label=label+1;
end
