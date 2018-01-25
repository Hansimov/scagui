figure;
hTabGroup = uitabgroup; drawnow;
tab1 = uitab(hTabGroup, 'title','Panel 1');
a = axes('parent', tab1); surf(peaks);
tab2 = uitab(hTabGroup, 'title','Panel 2');
uicontrol(tab2, 'String','Close', 'Callback','close(gcbf)');
set(gcf,'Renderer','painters','GraphicsSmoothing','off');