function plot_uvw(pos, uvw)
    %pos-current position
    %uvw-current direction

    o = pos;
    data = [repmat(o, size(uvw, 1), 1), uvw];
    color = ['r', 'b', 'y', 'k'];

    view(3)
    %  quiver3(data(:,1),data(:,2), ...
    %    data(:,3),data(:,4), ...
    %    data(:,5),data(:,6), ...
    %'LineWidth',2);
    hold off;

    for i = 1:size(data, 1)
        quiver3(data(i, 1), data(i, 2), ...
            data(i, 3), data(i, 4), ...
            data(i, 5), data(i, 6), ...
            color(i), 'LineWidth', 2);
        hold on;
    endfor

    axis([-10 10 -10 10 -10 10])
endfunction
