%% Comments
% I use procedural programming instead of object-oriented programming currently.
% This is because this project is under test.
% I will change the code to oop paradigm afterwards.
% Model-View-Controller pattern will be used.
% Why I name the labels and titles in Chinese? 
% Because this software is for Chinese students.
function scagui()
%% Initialization
close all;



%% Figure
fig_top = figure('Name','SCA Master', 'NumberTitle','off', 'Position',[100 200 1280 720]);
% fig_top.MenuBar = 'None';
% fig_top.Renderer = 'painters';


%% Menu
menu_file = uimenu(fig_top,'Label','文件');
menu_data = uimenu(fig_top,'Label', '数据');
menu_analysis = uimenu(fig_top, 'Label', '分析');

menu_file_open = uimenu(menu_file, 'Label', '新建');
menu_file_import = uimenu(menu_file, 'Label', '导入','Callback',@file_select);

menu_data_filter = uimenu(menu_data, 'Label', '滤波');
% menu_data_filter_lowpass = uimenu(menu_data_filter, 'Label', '低通');
menu_data_resample = uimenu(menu_data, 'Label', '重采样');
menu_data_align = uimenu(menu_data, 'Label','对齐');

menu_analysis_aes = uimenu(menu_analysis, 'Label','AES');

%% Panel
panel_plot = uipanel(fig_top,'Title','绘制区', 'FontSize',10,'Position',[0.3 0.3 0.7 0.7]);
panel_tips = uipanel(fig_top, 'Title','信息栏','FontSize',10,'Position',[0 0.3 0.3 0.7]);
stc = {'Male',52,true,[];'Male',40,true,[];'Female',25,false,[]};
% class(stc)
stc(end+1,:)= {'X',30,true,true};
table_files = uitable(panel_tips,'Data',stc);


%% Axes
% axes_plot = axes('Parent',fig_top,'Position',[0.3 0.3 0.7 0.7]);
% axes_plot = axes('Parent',panel_plot);
% x = -pi:0.1:pi;
% y = plot(x,sin(x),'Parent',axes_curve);
% axes_plot.Visible = 'off';

%% Plot

tabgroup_plot = uitabgroup(panel_plot);
tab1 = uitab(tabgroup_plot,'Title','原始');
tab2 = uitab(tabgroup_plot,'Title','低通');
tab3 = uitab(tabgroup_plot,'Title','对齐');

axes_plot1 = axes(tab1);
axes_plot2 = axes(tab2);
axes_plot3 = axes(tab3);

x = -pi:0.1:pi;
plot(x,sin(x),'Parent',axes_plot1);
plot(x,cos(x),'Parent',axes_plot2);
plot(x,tan(x),'Parent',axes_plot3);


% This improves the redering performance remarkably!
set(gcf, 'Renderer', 'painters');
% gcf.GraphicsSmoothing = 'off';
set(gca, 'SortMethod','childorder');


end