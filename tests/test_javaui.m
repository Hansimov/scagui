% function my_slider()
% hfig = figure();
% slider = uicontrol('Parent', hfig,'Style','slider',...
%          'Units','normalized',...
%          'Position',[0.3 0.5 0.4 0.1],...
%          'Tag','slider1',...
%          'UserData',struct('val',0,'diffMax',1),...
%          'Callback',@slider_callback);
% button = uicontrol('Parent', hfig,'Style','pushbutton',...
%          'Units','normalized',...
%          'Position',[0.4 0.3 0.2 0.1],...
%          'String','Display Difference',...
%          'Callback',@button_callback);
% end
% 
% function slider_callback(hObject,eventdata)
% 	sval = hObject.Value;
% 	diffMax = hObject.Max - sval;
% 	data = struct('val',sval,'diffMax',diffMax);
% 	hObject.UserData = data;
% 	% For R2014a and earlier: 
% 	% sval = get(hObject,'Value');  
% 	% maxval = get(hObject,'Max');  
% 	% diffMax = maxval - sval;      
% 	% data = struct('val',sval,'diffMax',diffMax);   
% 	% set(hObject,'UserData',data);   
% 
% end
% 
% function button_callback(hObject,eventdata)
% 	h = findobj('Tag','slider1');
% 	data = h.UserData;
% 	% For R2014a and earlier: 
% 	% data = get(h,'UserData'); 
% 	display([data.val data.diffMax]);
% end

% import javax.swing.*;
% % create the frame
% JF = JFrame;
% JF.setSize(300,300);
% % create the button
% JB = JButton('Press me');
% JF.getContentPane.add(JB)
% % this callback corresponds to the mouseClicked method of 
% % the MouseListener
% set(JB,'MouseClickedCallback',@plotsin)
% % display the frame
% JF.setVisible(true)
% 
% function plotsin(~,~)
%     figure;
%     x = -pi:0.1:pi;
%     y = sin(x);
%     plot(y);
% end

%%
close all;
import javax.swing.*
jf = JFrame('Demo');
% methods(jf)
jf.setSize(300,300);
jf.setVisible(true);
jin = JInternalFrame;
jin.setSize(40,40);
jin.setVisible(true);

jb = JButton('ss');
jin.getContentPane.add(jb);
jp = JTree;

jf.getContentPane.add(jp);

%%
jBarHandle = JProgressBar(0, 103);
jBarHandle.setStringPainted(true);
jBarHandle.setIndeterminate(false);

fig = figure('Position', [0 0 200 20]);
[jhandle, hhandle] = javacomponent(jBarHandle, [0 0 1 1], fig);
set(hhandle, 'parent', fig, 'Units', 'norm', 'Position', [0 0 1 1])

for k = 1:103
    javaMethodEDT('setValue', jBarHandle, k);
    pause(0.1);
end
%%
close all;
for i = 1:3
f = figure('WindowStyle','docked','MenuBar','None');
f.Renderer = 'painters';
end

%%
close all;clc;
% f = figure('MenuBar','none');
% jb = javacomponent(JButton);
jf = JFrame();
jf.setUndecorated(true);
jf.getRootPane().setWindowDecorationStyle(JRootPane.FRAME);
% methods(ji)
jf.setSize(100,40);
% jf.add(JButton)
jf.setVisible(true);
% jf = javacomponent(jf,[0 0 100 100],f);
%%
jf = JFrame;
jp = JPanel;

jf.getContentPane.add(jp);
jf.setSize(200,200);
jf.setVisible(true);
%%
jd = JDialog
jd.setVisible(true)