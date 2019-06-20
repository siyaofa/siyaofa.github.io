clear; close all; clc;

src = [1, 1, 1];

figure
hold off;

v = [-1, -1, 1];

quiver3(0, 0, 0, v(1), v(2), v(3), 'LineWidth', 5);

hold on;
axis([-3 3 -3 3 -3 3])

filename='octave_quaternion_rotate.gif'

for theta = 0:0.6:(2 * pi)
    dst = quaternion_rotate(src, v, theta);
    %plot3(dst);
    quiver3(0, 0, 0, dst(1), dst(2), dst(3));

    drawnow;
    frame = getframe(1);
    im = frame2im(frame);
    [imind, cm] = rgb2ind(im);

    if i == 1;
        imwrite(imind, cm, filename, 'gif', 'Loopcount', inf, 'DelayTime', 1);
    else
        imwrite(imind, cm, filename, 'gif', 'WriteMode', 'append', 'DelayTime', 1);
    end

    pause(0.1);
end
