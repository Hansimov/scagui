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
menu_file = uimenu(fig_top,'Label','�ļ�');
menu_data = uimenu(fig_top,'Label', '����');
menu_analysis = uimenu(fig_top, 'Label', '����');

menu_file_open = uimenu(menu_file, 'Label', '�½�');
menu_file_import = uimenu(menu_file, 'Label', '����','Callback',@file_select);

menu_data_filter = uimenu(menu_data, 'Label', '�˲�');
% menu_data_filter_lowpass = uimenu(menu_data_filter, 'Label', '��ͨ');
menu_data_resample = uimenu(menu_data, 'Label', '�ز���');
menu_data_align = uimenu(menu_data, 'Label','����');

menu_analysis_aes = uimenu(menu_analysis, 'Label','AES');

%% Panel
panel_curve = uipanel(fig_top,'Title','������', 'FontSize',10,'BackgroundColor','white','Position',[0.3 0.3 0.7 0.7]);
panel_tips = uipanel(fig_top, 'Title','��Ϣ��','FontSize',10,'Position',[0 0.3 0.3 0.7]);

end

%% File Select
function file_select(src,event)
[filename, pathname, ~] = uigetfile( ...
    {   '*.mat;*.trs','������������';...
        '*.mat','MAT ��ʽ (*.mat)'; ...
        '*.trs','trs ��ʽ (*.trs)'; ...
        '*.*',  '�����ļ� (*.*)'}, ...
    'ѡ���ļ�', ...
    'MultiSelect', 'on')
[pathname filename]
load([pathname filename])
end
