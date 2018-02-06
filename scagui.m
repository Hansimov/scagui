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
fig_top = figure('Name','SCA Master', 'NumberTitle','off', 'Position',[100 100 1080 520]);
fig_top.MenuBar = 'None';
% fig_top.Renderer = 'painters';

% This is a temporary expedient. 
% I will use handle later. Also rename this variable. 
global file_container file_pointer;
file_container = {};
file_pointer = {};

%% Panel

% box_tips = uipanel(fig_top, 'Title','信息栏','FontSize',10,'Position',[0 0.3 0.3 0.7]);
% box_plot = uipanel(fig_top,'Title','绘制区', 'FontSize',10,'Position',[0.3 0.3 0.7 0.7]);
hbox_top = uix.HBoxFlex('Parent',fig_top);
vbox_tips = uix.VBoxFlex('Parent',hbox_top);
vbox_plot = uix.VBoxFlex('Parent',hbox_top);




% table_files = uitable(box_tips,'Units','normalized','Position',[0 0.7 1.0 0.3]);
table_files = uitable('Parent',vbox_tips);
table_files.ColumnName = {'选中','文件','类型','路径'};
table_files.ColumnEditable = [true false false false];
table_files.ColumnWidth = {30 140 60 'auto'};
table_files.Data = file_pointer;

% table_traceinfo = uitable( box_tips,'Units','normalized','Position',[0 0 1.0 0.7]);
table_traceinfo = uitable('Parent',vbox_tips);
table_traceinfo.ColumnName = {'属性','值'};
table_traceinfo.ColumnWidth = {160 100};
table_traceinfo.RowStriping = 'off';
table_traceinfo.Data = {};

table_files.CellSelectionCallback = {@table_cell_operation,table_traceinfo};
% table_files.ButtonDownFcn = @fff;

set( hbox_top, 'Widths', [-1 -2], 'Spacing', 5 );
set( vbox_tips, 'Heights', [-1 -2], 'Spacing', 5 );
%% Menu
menu_file = uimenu(fig_top,'Label','文件');
menu_data = uimenu(fig_top,'Label', '数据');
menu_analysis = uimenu(fig_top, 'Label', '分析');

menu_file_new = uimenu(menu_file, 'Label', '新建');
menu_file_import = uimenu(menu_file, 'Label', '导入','Callback',{@import_file,table_files});

menu_data_filter = uimenu(menu_data, 'Label', '滤波');
% menu_data_filter_lowpass = uimenu(menu_data_filter, 'Label', '低通');
menu_data_resample = uimenu(menu_data, 'Label', '重采样');
menu_data_align = uimenu(menu_data, 'Label','对齐');

menu_analysis_aes = uimenu(menu_analysis, 'Label','AES');



%% Plot

tabgroup_plot = uitabgroup(vbox_plot);
% sld = uicontrol('Style', 'slider','Min',1,'Max',100,'Value',100, 'SliderStep',[0.01 0.01], ...
%                 'Units','normalized', 'Parent',box_plot,'Position', [0.98 0 0.1 1.0]); 
tab_plot ={};
tab_plot{1} = uitab(tabgroup_plot,'Title','原始');
tab_plot{2} = uitab(tabgroup_plot,'Title','低通');
tab_plot{3} = uitab(tabgroup_plot,'Title','对齐');

global axes_plot1;
axes_plot1 = axes(tab_plot{1});
axes_plot2 = axes(tab_plot{2});
axes_plot3 = axes(tab_plot{3});

% This improves the redering performance remarkably!
set(gcf, 'Renderer', 'painters');
set(gcf, 'GraphicsSmoothing', 'off');
set(gca, 'SortMethod','childorder');


end