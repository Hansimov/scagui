% https://undocumentedmatlab.com/blog/tab-panels-uitab-and-relatives
% https://undocumentedmatlab.com/blog/uitab-customizations
% https://undocumentedmatlab.com/blog/uitab-colors-icons-images


%% ordinary uitab
close all;
figure;
set(gcf,'MenuBar','None');
hTabGroup = uitabgroup; drawnow;
tab1 = uitab(hTabGroup, 'title','Panel 1');
a = axes('parent', tab1); surf(peaks);
tab2 = uitab(hTabGroup, 'title','Panel 2');
uicontrol(tab2, 'String','Close', 'Callback','close(gcbf)');
% set(hTabGroup,'SelectedTab',tab2);   % activate second tab

% customize uitab
 
% A direct alternative for getting jTabGroup (only works up to R2014a!)
% jTabGroup = getappdata(handle(hTabGroup),'JTabbedPane');
 
% Now use the Java reference to set the title, tooltip etc.
% jTabGroup.setTitleAt(1,'Tab #2');
% jTabGroup.setTitleAt(1,'<html><b><i><font size=+2>Tab #2');
% jTabGroup.setToolTipTextAt(1,'Tab #2');
%  
% Disabling tabs can only be done using the Java handle:
% jTabGroup.setEnabledAt(1,0);  % disable only tab #1 (=2nd tab)
% jTabGroup.setEnabled(false);  % disable all tabs


% Add close icon
% First let's load the close icon
% jarFile = fullfile(matlabroot,'/java/jar/mwt.jar');
% iconsFolder = '/com/mathworks/mwt/resources/';
% iconURI = ['jar:file:/' jarFile '!' iconsFolder 'closebox.gif'];
% icon = javax.swing.ImageIcon(java.net.URL(iconURI));

[p,~,~] = fileparts(mfilename('fullpath'));
% cd(p);
% imshow('scagui\functions\GUI Design\images\closebox.gif')
icon = javax.swing.ImageIcon( ...
    './closebox.gif');
%     'D:\MATLAB R2017a\help\matlab\matlab_env\closebox.gif');
%     'F:\Sources\MATLAB\work\scagui\functions\GUI Design\images\close.png');

% Now let's prepare the close button: icon, size and callback
jCloseButton = handle(javax.swing.JButton,'CallbackProperties');
jCloseButton.setIcon(icon);
jCloseButton.setPreferredSize(java.awt.Dimension(15,15));
jCloseButton.setMaximumSize(java.awt.Dimension(15,15));
jCloseButton.setSize(java.awt.Dimension(15,15));
set(jCloseButton, 'ActionPerformedCallback',@(h,e)delete(tab2));

jCloseButton2 = handle(javax.swing.JButton,'CallbackProperties');
jCloseButton2.setIcon(icon);
jCloseButton2.setPreferredSize(java.awt.Dimension(15,15));
jCloseButton2.setMaximumSize(java.awt.Dimension(15,15));
jCloseButton2.setSize(java.awt.Dimension(15,15));
set(jCloseButton2, 'ActionPerformedCallback',@(h,e)disp('hello'));

% Now let's prepare a tab panel with our label and close button
jPanel = javax.swing.JPanel;	% default layout = FlowLayout
set(jPanel.getLayout, 'Hgap',0, 'Vgap',0);  % default gap = 5px
jLabel = javax.swing.JLabel('Tab #2  ');
jPanel.add(jLabel);
jPanel.add(jCloseButton);
jPanel.add(jCloseButton2);

% Now attach this tab panel as the tab-group's 2nd component
% Get the underlying Java reference using FindJObj
jTabGroup = findjobj('class','JTabbedPane');
% This line displays the icon.
jTabGroup.setTabComponentAt(1,jPanel);	% Tab #1 = second tab

