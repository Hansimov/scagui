%%
import javax.swing.*
import java.awt.*
import javax.swing.event.*

frame = JFrame('JTabbedPane');
tabbedPane = JTabbedPane;
tabbedPane.addTab("Mercury",[]);
tabbedPane.addTab("Venus",[]);
tabbedPane.addTab("Earth",[]);
tabbedPane.addTab("Mars",[]);
tabbedPane.addTab("Jupiter",[]);
tabbedPane.addTab("Saturn",[]);
tabbedPane.addTab("Uranus",[]);
tabbedPane.addTab("Neptune",[]);
tabbedPane.addTab("Pluto",[]);
tabbedPane.setVisible(true);
frame.add(tabbedPane);
frame.setSize(500,300);
frame.setVisible(true);
hframe = handle(frame,'CallbackProperties');


%% 
import javax.swing.*
import java.awt.*
import javax.swing.event.*

% https://undocumentedmatlab.com/blog/matlab-callbacks-for-java-events-in-r2014a

% f = figure;
jf = JFrame('JButton');
jb = javax.swing.JButton('click me');
jf.add(jb);
% javacomponent(jButton, [50,50,80,20], gcf);
hb = handle(jb,'CallbackProperties');
% Set the Matlab callbacks to the JButton's events
set(hb, 'MouseEnteredCallback', @(h,e)set(jb,'Text','NOW !!!'))
set(hb, 'MouseExitedCallback',  @(h,e)jb.setText('click me'))
jf.setVisible(true);

%%
import javax.swing.*
import java.awt.*

close all
mf = figure('Name','matlab figure');
jf = JButton('java frame');

javacomponent(jf,[],mf);

%%
f = figure;
b = javacomponent({'javax.swing.JButton','Hello'}, [], f,  ...
    {'ActionPerformed','disp Hi'});
%%
f = figure;
[comp, container] = javacomponent('javax.swing.JSpinner');
container.Position = [100, 100, 100, 40];
container.Units = 'normalized';