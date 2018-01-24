a.t = 'tt';
a.s = 'ss';
mytxt = uicontrol('Style','text','Min',3,'Max',6,'String',{a.t,a.s});
% mytxt.Enable = 'Inactive';
mytxt.Position = [100 100 100 100];
% mytxt.ButtonDownFcn = 'disp(''Text was clicked'')';