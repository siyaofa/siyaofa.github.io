function [acc_data,gyro_data,compass_data] = gy85_sample(sample_num)
#sample_num 采样次数

pkg load instrument-control

##if (exist("serial") == 3)
##    disp("Serial: Supported")
##else
##    disp("Serial: Unsupported")
##endif

s1 = serial("COM5", 115200,10);
srl_flush(s1); 
pause_time=0.005;#发送后等待再读取数据

acc=zeros(1,3);
compass=zeros(1,3);
gyro=zeros(1,4);
#temporature=gyro(4);# 35+( raw + 13200 ) / 280

## 绕各轴旋转 校正加速度传感器
for i=1:sample_num
  ##srl_write(s1, "refresh");
  ## 等待arduino 返回数据
  ##pause(pause_time)
  [uint8_data,count] = srl_read(s1,20);
  if(count<20)
    disp("count<20 lost data")
  endif
  raw_data(i,:)=uint8_data;
end

for i=1:sample_num
  ## 按指定格式解析数据
  uint8_data=raw_data(i,:);
  [acc,compass,gyro]=parse_data(uint8_data);
  acc_data(i,:)=acc;
  gyro_data(i,:)=gyro;
  compass_data(i,:)=compass;
end

fclose(s1) # Closes and releases serial interface object

endfunction
