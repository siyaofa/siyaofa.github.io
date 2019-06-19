function [acc_data, gyro_data, compass_data] = gy85_sample(sample_num)
    % sample_num the data number that we want
    % return
    % acc_data gyro_data compass_data

    pkg load instrument - control

    %%if (exist("serial") == 3)
    %%    disp("Serial: Supported")
    %%else
    %%    disp("Serial: Unsupported")
    %%endif

    % com name should check from arduino IDE
    % my script is working on Windows
    s1 = serial('COM5', 115200, 10);
    srl_flush(s1);

    % maybe we should wait a momment for arduino return data
    pause_time = 0.005;

    acc = zeros(1, 3);
    compass = zeros(1, 3);
    gyro = zeros(1, 4);
    %temporature=gyro(4);% 35+( raw + 13200 ) / 280

    %% get serial data from arduino
    for i = 1:sample_num
        %% srl_write(s1, "refresh");
        %% wati arduino return data
        %%pause(pause_time)
        [uint8_data, count] = srl_read(s1, 20);

        if (count < 20)
            disp('count<20 lost data')
        endif

        raw_data(i, :) = uint8_data;
    end

    %% parse raw data, the protocol must same as arduino
    for i = 1:sample_num
        uint8_data = raw_data(i, :);
        [acc, compass, gyro] = parse_data(uint8_data);
        acc_data(i, :) = acc;
        gyro_data(i, :) = gyro;
        compass_data(i, :) = compass;
    end

    fclose(s1)% Closes serial

endfunction
