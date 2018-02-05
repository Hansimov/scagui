%% JSplitPane
% Prepare the top-bottom JSplitPanes
import java.awt.*
import javax.swing.*

jf = JFrame('SCA Master');

% jt = JTabbedPane;
% jt.setSize(100,100);
% jt.setVisible(true);

jf.setSize(300,200);
% jf.getContentPane.add(jt);


set(jf,'Visible',true);

%% Drag and Drop
import java.awt.*
import javax.swing.*

jf = JFrame('Drag and Drop');

% jf.setLayout(null); % Use the line below instead.
jf.setLayout([]);

jb = JButton('Button');
jb.setBounds(150,50,90,25);

jfield = JTextField;
jfield.setBounds(30,50,90,25);

jf.add(jb);
jf.add(jfield);

jfield.setDragEnabled(true);
jb.setTransferHandler(TransferHandler('A text'));

jf.setSize(350,200);
% jf.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE); % This will make matlab exit too.
jf.setLocationRelativeTo([]);
jf.setVisible(true);

m=0;
set(jb,'MouseDraggedCallback','disp(m),m=m+1;');
uiinspect(jb);

%% Place java component in MATLAB figure
close all;
import javax.swing.*

f = figure('Name','Place Java Component','NumberTitle','off','MenuBar','None');

% javaObjectEDT('javax.swing.JButton','A Button');
jb = JButton;
m=0;
set(jb,'MouseDraggedCallback','disp(m),m=m+1;');

javacomponent(jb, [20 20 40 40], f);
% uiinspect(jb);
% js = JSplitPane;
% js = javacomponent(js,[],f);







