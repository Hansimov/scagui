% https://undocumentedmatlab.com/blog/tab-panels-uitab-and-relatives


%% ordinary uitab
close all;
figure;
hTabGroup = uitabgroup; drawnow;
tab1 = uitab(hTabGroup, 'title','Panel 1');
a = axes('parent', tab1); surf(peaks);
tab2 = uitab(hTabGroup, 'title','Panel 2');
uicontrol(tab2, 'String','Close', 'Callback','close(gcbf)');
set(hTabGroup,'SelectedTab',tab2);   % activate second tab

%% customize uitab
% Get the underlying Java reference using FindJObj
jTabGroup = findjobj('class','JTabbedPane');
 
% A direct alternative for getting jTabGroup (only works up to R2014a!)
% jTabGroup = getappdata(handle(hTabGroup),'JTabbedPane');
 
% Now use the Java reference to set the title, tooltip etc.
jTabGroup.setTitleAt(1,'Tab #2');
jTabGroup.setTitleAt(1,'<html><b><i><font size=+2>Tab #2');
jTabGroup.setToolTipTextAt(1,'Tab #2');
 
% Disabling tabs can only be done using the Java handle:
jTabGroup.setEnabledAt(1,0);  % disable only tab #1 (=2nd tab)
jTabGroup.setEnabled(false);  % disable all tabs