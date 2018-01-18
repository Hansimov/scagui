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
fig_top = figure('Name','SCA Master', 'MenuBar','None', 'NumberTitle','off', 'Position',[100 200 1280 720]);

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
panel_curve = uipanel(fig_top,'Title','绘制区', 'FontSize',10,'BackgroundColor','white','Position',[0.3 0.3 0.7 0.7]);
panel_tips = uipanel(fig_top, 'Title','信息栏','FontSize',10,'Position',[0 0.3 0.3 0.7]);

end

%% File Select
function file_select(src,event)
[filename, pathname, ~] = uigetfile( ...
    {   '*.mat;*.trs','所有数据类型';...
        '*.mat','MAT 格式 (*.mat)'; ...
        '*.trs','trs 格式 (*.trs)'; ...
        '*.*',  '所有文件 (*.*)'}, ...
    '选择文件', ...
    'MultiSelect', 'on')
[pathname filename]
load([pathname filename])
end
