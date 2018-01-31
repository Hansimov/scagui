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
global file_pointer file_info file_entity;
file_pointer = {};
file_info = {};
file_entity = {};

%% Panel
panel_plot = uipanel(fig_top,'Title','������', 'FontSize',10,'Position',[0.3 0.3 0.7 0.7]);
panel_tips = uipanel(fig_top, 'Title','��Ϣ��','FontSize',10,'Position',[0 0.3 0.3 0.7]);

table_traceinfo = uitable(panel_tips,'Units','normalized','Position',[0 0 1.0 0.7]);
table_traceinfo.ColumnName = {'����','ֵ'};
table_traceinfo.ColumnWidth = {160 100};
table_traceinfo.RowStriping = 'off';
table_traceinfo.Data = {};

table_files = uitable(panel_tips,'Units','normalized','Position',[0 0.7 1.0 0.3]);
table_files.ColumnName = {'ѡ��','�ļ�','����','·��'};
table_files.ColumnEditable = [true false false false];
table_files.ColumnWidth = {30 140 60 'auto'};
table_files.Data = file_pointer;
table_files.CellSelectionCallback = {@table_cell_operation,table_traceinfo};
% table_files.ButtonDownFcn = @fff;

%% Menu
menu_file = uimenu(fig_top,'Label','�ļ�');
menu_data = uimenu(fig_top,'Label', '����');
menu_analysis = uimenu(fig_top, 'Label', '����');

menu_file_new = uimenu(menu_file, 'Label', '�½�');
menu_file_import = uimenu(menu_file, 'Label', '����','Callback',{@import_file,table_files});

menu_data_filter = uimenu(menu_data, 'Label', '�˲�');
% menu_data_filter_lowpass = uimenu(menu_data_filter, 'Label', '��ͨ');
menu_data_resample = uimenu(menu_data, 'Label', '�ز���');
menu_data_align = uimenu(menu_data, 'Label','����');

menu_analysis_aes = uimenu(menu_analysis, 'Label','AES');


%% Axes
% axes_plot = axes('Parent',fig_top,'Position',[0.3 0.3 0.7 0.7]);
% axes_plot = axes('Parent',panel_plot);
% x = -pi:0.1:pi;
% y = plot(x,sin(x),'Parent',axes_curve);
% axes_plot.Visible = 'off';

%% Plot

tabgroup_plot = uitabgroup(panel_plot);
tab_plot ={};
tab_plot{1} = uitab(tabgroup_plot,'Title','ԭʼ');
tab_plot{2} = uitab(tabgroup_plot,'Title','��ͨ');
tab_plot{3} = uitab(tabgroup_plot,'Title','����');

axes_plot1 = axes(tab_plot{1});
axes_plot2 = axes(tab_plot{2});
axes_plot3 = axes(tab_plot{3});

x = -pi:0.1:pi;
plot(x,sin(x),'Parent',axes_plot1);
plot(x,cos(x),'Parent',axes_plot2);
plot(x,tan(x),'Parent',axes_plot3);

% This improves the redering performance remarkably!
set(gcf, 'Renderer', 'painters');
% gcf.GraphicsSmoothing = 'off';
set(gca, 'SortMethod','childorder');


end