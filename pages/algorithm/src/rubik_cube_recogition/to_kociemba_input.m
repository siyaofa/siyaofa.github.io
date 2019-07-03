function kociemba_input=to_kociemba_input(facelet_label_map)
%{'Up.png', 'Front.png', 'Down.png', 'Right.png', 'Back.png', 'Left.png'};
%to UUUUUUUUURRRRRRRRRFFFFFFFFFDDDDDDDDDLLLLLLLLLBBBBBBBBB
kociemba_input='';

UFDRBL_number=facelet_label_map(2,2,:);
UFDRBL_char=['U','F','D','R','B','L'];

URFDLB =  facelet_label_map;

URFDLB(:,:,2)=facelet_label_map(:,:,4);
URFDLB(:,:,3)=facelet_label_map(:,:,2);
URFDLB(:,:,4)=facelet_label_map(:,:,3);
URFDLB(:,:,5)=facelet_label_map(:,:,6);
URFDLB(:,:,6)=facelet_label_map(:,:,5);


for f=1:6
  for h=1:3
    for w=1:3
      index=find(UFDRBL_number==URFDLB(h,w,f));
      kociemba_input=[kociemba_input UFDRBL_char(index)];
    end
  end
end
 
 kociemba_input=['kociemba.solve(' "'" kociemba_input "'" ')'];

end
