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

% This is a temporary expedient. 
% I will use handle later. Also rename this variable. 
global file_container file_pointer jPanel;
file_container = {};
file_pointer = {};
jPanel = {};

%% Panel

% box_tips = uipanel(fig_top, 'Title','��Ϣ��','FontSize',10,'Position',[0 0.3 0.3 0.7]);
% box_plot = uipanel(fig_top,'Title','������', 'FontSize',10,'Position',[0.3 0.3 0.7 0.7]);
hbox_top = uix.HBoxFlex('Parent',fig_top);
vbox_tips = uix.VBoxFlex('Parent',hbox_top);
vbox_plot = uix.VBoxFlex('Parent',hbox_top);

table_files = Xuitable('Parent',vbox_tips);
table_files.m.ColumnName = {'ѡ��','�ļ�','����','·��'};
table_files.m.ColumnEditable = [true false false false];
table_files.m.ColumnWidth = {30 140 60 'auto'};
table_files.m.Data = file_pointer;

table_traceinfo = Xuitable('Parent',vbox_tips);
table_traceinfo.m.ColumnName = {'����','ֵ'};
table_traceinfo.m.ColumnWidth = {160 100};
table_files.m.CellSelectionCallback = {@table_cell_operation,table_traceinfo.m};


set( hbox_top, 'Widths', [-1 -2], 'Spacing', 5 );
set( vbox_tips, 'Heights', [-1 -2], 'Spacing', 5 );
%% Menu
menu_file = uimenu(fig_top,'Label','�ļ�');
menu_data = uimenu(fig_top,'Label', '����');
menu_analysis = uimenu(fig_top, 'Label', '����');

menu_file_new = uimenu(menu_file, 'Label', '�½�');
menu_file_import = uimenu(menu_file, 'Label', '����','Callback',{@import_file,table_files.m});

menu_data_filter = uimenu(menu_data, 'Label', '�˲�');
% menu_data_filter_lowpass = uimenu(menu_data_filter, 'Label', '��ͨ');
menu_data_resample = uimenu(menu_data, 'Label', '�ز���');
menu_data_align = uimenu(menu_data, 'Label','����');

menu_analysis_aes = uimenu(menu_analysis, 'Label','AES');


%% Plot

tabgroup_plot = uitabgroup(vbox_plot);

global jTabGroup;
jTabGroup = findjobj('class','JTabbedPane','persist');

tab_plot ={};
tab_plot{1} = Xuitab(tabgroup_plot,'Title','ԭʼ');
tab_plot{2} = Xuitab(tabgroup_plot,'Title','��ͨ');
tab_plot{3} = Xuitab(tabgroup_plot,'Title','����');

global axes_plot1;
axes_plot1 = axes(tab_plot{1}.m);
axes_plot2 = axes(tab_plot{2}.m);
axes_plot3 = axes(tab_plot{3}.m);

% delete(tab_plot{1}.m);delete(tab_plot{1});
% tab_plot(1) = [];
% disp(tab_plot{1}.m.Title)
% numel(tab_plot)


% This improves the redering performance remarkably!
% set(gcf, 'Renderer', 'painters'); % While 3D plots, 'opengl' is much faster than 'painters'
set(gcf, 'GraphicsSmoothing', 'off');
set(gca, 'SortMethod','childorder');


end