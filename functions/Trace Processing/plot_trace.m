function plot_trace(sample, unitx, unity)
    global axes_plot1;
    t = 1:size(sample,2);
    x = t * unitx;
    y = double(sample) * unity;
    plot(axes_plot1,x,y);
    axes_plot1.XLabel.String='S';
    axes_plot1.YLabel.String='V';
    axes_plot1.XLim = [0 inf];
end