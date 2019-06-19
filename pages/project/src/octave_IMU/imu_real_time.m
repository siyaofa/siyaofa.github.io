function imu_real_time()

    title('Acc-Red Mag-Blue')
    filename='GY-85_Acc_Mag.gif';
    for i = 1:100

        [acc_data, gyro_data, compass_data] = gy85_sample(1);

        % g=9.8;
        % acc factor and offset
        acc_offset = [5.6804; 13.827; 5.8449; 12.519; 0.46976; 14.399];
        offset = [acc_offset(1), acc_offset(3), acc_offset(5)];
        scale = [acc_offset(2), acc_offset(4), -acc_offset(6)];
        % calibration acc data
        acc_uvw = (acc_data - offset) ./ scale;
        % normalization compass vector
        compass_data
        compass_uvw = 5 * compass_data / norm(compass_data);
        % current positon
        pos = [0, 0, 0];
        plot_uvw(pos, [acc_uvw; compass_uvw]);
        % save image as gif
        drawnow;
        frame = getframe(1);
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im);
        
        if i == 1;
        imwrite(imind,cm,filename,'gif', 'Loopcount',inf,'DelayTime',1);
        else
        imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',1);
        end
        pause(0.05)
    end

endfunction
