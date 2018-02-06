%% JTable
import javax.swing.*
import java.awt.*
import java.util.*
import java.swing.table.*

f = figure( 'Name', 'JTable Demo');
f.NumberTitle = 'off';
f.ToolBar = 'none';
f.MenuBar = 'none';

columnname = {'ss','yy'};
data = {'1','2';'3','4';'k','k'};

jcolumnname = {'ss','yy','zzz','x'};
jdata = {'1','2','5',false;'3','4',int8(7),true};

% https://stackoverflow.com/a/22303301/8328786
% To display 
jt = JTable(jdata,jcolumnname);
js = JScrollPane;
js.setViewportView(jt);
% jjs =javacomponent(js,[10 10 400 200],f);

box1 = uix.HBoxFlex('Parent',f);
jjs =javacomponent(js,[0 0 100 200],box1);
set( box1, 'Widths', [-1], 'Spacing', 5 );

% jt = javaObjectEDT('javax.swing.JTable');
% numel(methods(jt))
% jt.getCellRenderer(1,1).getVerticalAlignment()
% jt.getDefaultRenderer(...)

col1 = jt.getColumnModel().getColumn(1);
comboBox = JComboBox();
comboBox.addItem("Snowboarding");
comboBox.addItem("Rowing");
comboBox.addItem("Chasing toddlers");
comboBox.addItem("Speed reading");
comboBox.addItem("Teaching high school");
comboBox.addItem("None");
col1.setCellEditor(DefaultCellEditor(comboBox));

% jt.setVisible(true);

jt.setShowGrid(false);
jt.getModel().setValueAt('newval', 1, 1);
% jt.setAutoCreateRowSorter(true);

% jjt = javacomponent(jt);


%% Customizing uitable
import javax.swing.*
import java.awt.*
import java.swing.table.*
import com.mathworks.hg.peer.ui.table.*

f = figure;
% https://undocumentedmatlab.com/blog/uitable-sorting
%   "New uitable sorting"

% data = {'a','b','<html><tr><td align=left width=9999>Right'; 1, 2, 3; 0.1, 0.2, 0.3};
data = {'a','b',2; 'b', 2, 3; 'c', 0.2, 0.3;'d','x',4};
% data = {'a','b','2'; 'b', '2', '3'; 'c', '0.2', '0.3';'d','x','4'};
mtable = uitable(f, 'Data',data, 'ColumnName',{'A', 'B', 'C'});
mtable.Units = 'normalized';
mtable.Position = [0.1 0.1 0.5 0.5];
mtable.RowStriping = 'off';

tooltip = '<html><b>UITable tooltip</b>';
mtable.TooltipString = tooltip;
% mtable.ColumnEditable = [true,true,true];
% mtable.ColumnFormat = {'char' [] []};
% mtable.Data(2,2) = {'xx'};


jscrollpane = findjobj(mtable);
jtable = jscrollpane.getViewport.getView;
% uiinspect(jtable);
% size(methods(jtable))

% ------------------ Alignment START ------------------ %
% 'char'   :  LEADING  / LEFT
% 'numeric':  TRAILING / RIGHT
% 
%
% Support:
% - CellRenderer only works when the cell is string('char')
% - ALL LEFT/CENTER/RIGHT : Change all ColumnFormat to 'char', and set to Target Alignment
% - Number RIGHT and String ANY
%
% https://groups.google.com/d/msg/comp.soft-sys.matlab/KworAFwp5uw/Q1BxVip_qdMJ
% https://docs.oracle.com/javase/7/docs/api/javax/swing/table/DefaultTableCellRenderer.html
% https://docs.oracle.com/javase/7/docs/api/javax/swing/JLabel.html#setHorizontalAlignment(int)
% http://undocumentedmatlab.com/blog/aligning-uicontrol-contents

renderer2 = jtable.getCellRenderer(0,1);
% tm=jtable.getColumnModel.getColumn(1).getHeaderRenderer.getCellRenderer;
% uiinspect(tm)
% get(tm)
% get(tm)
% tm.getHorizontalAlignment()
% tm.setHorizontalAlignment(javax.swing.SwingConstants.LEFT);
% tm.getHorizontalAlignment()

% tm2=jtable.getColumnModel.getColumn(1).getHeaderRenderer.getCellRenderer;
% tm2.getHorizontalAlignment()
% tm3=jtable.getColumnModel.getColumn(1).getHeaderRenderer.getCellRenderer.getHorizontalAlignment()
% tm.setForeground(java.awt.Color.red);
% renderer3 = jtable.getCellRenderer(2,1);
% renderer2 = jtable.getColumnModel().getColumn(0);
% renderer2.setCellRenderer(renderer3);

% get(renderer2)
% renderer1 = com.mathworks.hg.peer.ui.table.UIStyledTableCellRenderer;
% renderer1
% % renderer1.setLocation(-74,-18)
% % renderer1.getHorizontalAlignment()
% rd1 = get(renderer1);
% rd2 = get(renderer2);
% 
% fd1 = fieldnames(rd1);
% fd2 = fieldnames(rd2);
% 
% gt1 = struct2cell(rd1);
% gt2 = struct2cell(rd2);
% 
% for i = 1:numel(gt1)
%     if ~isequal(gt1{i},gt2{i})
% %         num = i
%         fd1{i},gt1{i}
%         fd2{i};gt2{i}
% %         eval(['rd1.' fd1{i} '=' 'rd2.' fd2{i} ';']);
%     end
% end

% com.mathworks.hg.peer.ui.table.UIStyledTableCellRenderer = rd1
% renderer1 = renderer2;
% renderer1 =renderer3;
% renderer1.setHorizontalAlignment(javax.swing.SwingConstants.RIGHT);
% renderer3.getHorizontalAlignment()
mtable.ColumnFormat = {'char' 'char' 'char'};
renderer2.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
% methods(renderer1)
% uiinspect(renderer1);
% renderer1.getHorizontalAlignment()

% mtable.ColumnFormat = {[] 'numeric' 'char' };
renderer2 = jtable.getCellRenderer(1,1);
% renderer2.setHorizontalAlignment(javax.swing.SwingConstants.LEFT);

% renderer2.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
% mtable.ColumnFormat = {'char' 'char' 'char'};

% cc = jtable.getColumnModel();
% cc.getColumn(0).setCellRenderer(renderer2);

% ------------------ Alignment END ------------------ %

% This link may be helpful to set alignment of cells
% https://stackoverflow.com/a/18926688/8328786

% jtable.getDefaultCellRenderer()
% jtable.getColumnModel().getColumnMargin()
% jtable.setDefaultCellRenderer(jtable.getDefaultCellRenderer)

% 
% ha = get(UIStyledTableCellRenderer,'HorizontalAlignment');
% set(UIStyledTableCellRenderer,'HorizontalAlignment',ha);
% % get(com.mathworks.hg.peer.ui.table.UIStyledTableCellRenderer)
% jtable.getCellRenderer(2,1)
% tmp=jtable.getCellRenderer(1,1);
% tmp.setHorizontalAlignment(javax.swing.SwingConstants.CENTER)


% jtable.setDefaultCellRenderer()

% ------------------ Sort ------------------ %
% Now turn the JIDE sorting on
jtable.setSortable(true);		% or: set(jtable,'Sortable','on');
jtable.setAutoResort(true);
jtable.setMultiColumnSortable(true);
jtable.setPreserveSelectionsAfterSorting(true);
jtable.setAutoResizeMode(true);

% jtable.setSortOrderForeground(java.awt.Color.blue);
jtable.setShowSortOrderNumber(true);
jtable.setColumnResizable(true);
% jtable.setRowResizable(true);
% jtable.setRowSelectionAllowed(true);
% jtable.setEnabled(false);
% jtable.setShowVerticalLines(true);
% jtable.setDragEnabled(true);

% jtable.setModel(javax.swing.table.DefaultTableModel(data,cols));
% jtable.setBackground(java.awt.Color.cyan);
% jtable.setScrollRowWhenRowHeightChanges(true);

% ------------------ Sort END ------------------ %

% ------------------ Listbox ------------------ %
% col1 = jtable.getColumnModel().getColumn(1);
% comboBox = JComboBox();
% comboBox.addItem("Snowboarding");
% comboBox.addItem("Rowing");
% comboBox.addItem("Chasing toddlers");
% comboBox.addItem("Speed reading");
% comboBox.addItem("Teaching high school");
% comboBox.addItem("None");
% col1.setCellEditor(DefaultCellEditor(comboBox));
% javacomponent(comboBox,[],f);

% ------------------ Listbox END ------------------ %




% -----------------------------------------------------------------------------
% The lines below do not work!
% gtable = mtable.getTable;
% cr = javax.swing.table.DefaultTableCellRenderer;
% cr.setForeground(java.awt.Color.red);
% gtable.getColumnModel.getColumn(1).setCellRenderer(cr); % 1=B 
% gtable.repaint; % repaint the table to use the new CellRenderer 
% -----------------------------------------------------------------------------

% mtable.Data = rand(3);

jtable.repaint;

%% Mtable class
import javax.swing.*
import java.awt.*
clear classes
f = figure;
data = {'a','b','<html><div style="text-align:right">text'; 1, 2, 3; 0.1, 0.2, 0.3};
a = Mtable(f, 'Data',data, 'ColumnName',{'<html><b>A', '<html><b>B', '<html><b>C'});
% a = Mtable();
a.m.Units = 'normalized';
a.m.Position = [0.1 0.1 0.5 0.5];
% a.m.RowStriping = 'on';

% tooltip = '<html><b>UITable tooltip</b>';
% a.m.TooltipString = tooltip;
a.m.ColumnEditable = [false,false,true];
% a.m.ColumnFormat = repmat({'char'},1,3);
% a.m.ColumnFormat = {'numeric' 'numeric' 'bank'};
% a.m.Data(2,2) = {'xx'};
a.setColumnChar();
% a.setColumnAlignment('ss',{1,2});
% a.j.setRowMargin(10);
% a.j.getWidth();


% a.j.getColumnCount()

%% uicontrol
f2 = figure;
ctext = uicontrol('Parent',f2,'Style','text','String','mytext');
ctext.HorizontalAlignment = 'center';







