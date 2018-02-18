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
    global tab_container tabgroup_plot;
    t = 1:size(sample,2);
    x = t * unitx;
    y = double(sample) * unity;
    tab_container{end+1,1} = Xuitab(tabgroup_plot,'Title','ԭʼ');
    current_axes = axes(tab_container{end,1}.m);
    plot(current_axes,x,y);
    current_axes.XLabel.String='S';
    current_axes.YLabel.String='V';
    current_axes.XLim = [0 inf];
end