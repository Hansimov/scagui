%% Comments
% I use procedural programming instead of object-oriented programming currently.
% This is because this project is under test.
% I will change the code to oop paradigm afterwards.
% Model-View-Controller paradigm will be used.
% Why I name the labels and titles in Chinese? 
% Because this software is for Chinese students.

function scagui()
%% Initialization
close all;

%% Figure
fig_top = figure('Name','SCA Master', 'NumberTitle','off', 'Position',[100 100 1080 520]);
fig_top.MenuBar = 'None';
% fig_top.Renderer = 'painters';

global container;
container = GlobalContainer;

%% Panel

hbox_top = uix.HBoxFlex('Parent',fig_top);
vbox_tips = uix.VBoxFlex('Parent',hbox_top);
vbox_plot = uix.VBoxFlex('Parent',hbox_top);

tabgroup_variables = uitabgroup('Parent',vbox_tips);

tab_files = uitab(tabgroup_variables,'Title','文件');
tab_traces = uitab(tabgroup_variables, 'Title','曲线');

vbox_files = uix.VBoxFlex('Parent',tab_files);
table_files = Xuitable('Parent',vbox_files);
table_files.m.ColumnName = {'选中','文件','类型','路径'};
table_files.m.ColumnEditable = [true false false false];
table_files.m.ColumnWidth = {35 100 60 100};
table_files.m.Data = container.file_pointers;
table_files.m.CellEditCallback = @table_files.updateTable;

vbox_traces = uix.VBoxFlex('Parent',tab_traces);
table_traces = Xuitable('Parent',vbox_traces);
table_traces.m.ColumnName = {'选中','变量','类型'};
table_traces.m.ColumnWidth = {35 100 60};
table_traces.m.ColumnEditable = [true false false];



table_traceinfo = Xuitable('Parent',vbox_tips);
table_traceinfo.m.ColumnName = {'属性','值'};
table_traceinfo.m.ColumnWidth = {160 100};
table_files.m.CellSelectionCallback = {@tableOperation,table_traceinfo.m};

set( hbox_top, 'Widths', [-1 -2], 'Spacing', 5 );
set( vbox_tips, 'Heights', [-1 -2], 'Spacing', 5 );
%% Menu
menu_file = uimenu(fig_top,'Label','文件');
menu_data = uimenu(fig_top,'Label', '数据');
menu_analysis = uimenu(fig_top, 'Label', '分析');

menu_file_new = uimenu(menu_file, 'Label', '新建');
menu_file_import = uimenu(menu_file, 'Label', '导入','Callback',{@importFile,table_files.m});

menu_data_downsample = uimenu(menu_data, 'Label', '重采样');
menu_data_downsample.Callback = @dataDownSample;
menu_data_filter = uimenu(menu_data, 'Label', '滤波');
% menu_data_filter_lowpass = uimenu(menu_data_filter, 'Label', '低通');
menu_data_align = uimenu(menu_data, 'Label','对齐');

menu_analysis_aes = uimenu(menu_analysis, 'Label','AES');


%% Plot
container.tabgroup = uitabgroup(vbox_plot);

% global jTabGroup;
% jTabGroup = findjobj('class','JTabbedPane','persist');

% This improves the redering performance remarkably!
% set(gcf, 'Renderer', 'painters'); % While 3D plots, 'opengl' is much faster than 'painters'
set(gcf, 'GraphicsSmoothing', 'off');
set(gca, 'SortMethod','childorder');


end