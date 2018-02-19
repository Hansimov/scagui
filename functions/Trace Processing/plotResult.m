function plotResult(sample, varargin)
% Afterwards I will check whether the trace has been displayed.
% The type of sample is number vector.
    if nargin == 1
        unitx = 1;
        unity = 1;
    else
        unitx = varargin{1};
        unity = varargin{2};
    end
    global container;
    t = 1:size(sample,2);
    x = t * unitx;
    y = double(sample) * unity;
    container.tabs{end+1,1} = Xuitab(container.tabgroup,'Title','ԭʼ');
    current_axes = axes(container.tabs{end,1}.m);
%     getpixelposition(container.tabs{end,1}.m)

    plot(current_axes,x,y);
    current_axes.XLabel.String='S';
    current_axes.YLabel.String='V';
    current_axes.XLim = [0 inf];
end