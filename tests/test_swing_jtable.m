%% JTable
import javax.swing.*
import java.awt.*
import java.util.*

f = figure( 'Name', 'JTable Demo');
f.NumberTitle = 'off';
f.ToolBar = 'none';
f.MenuBar = 'none';

columnname = {'ss','yy'};
data = {'1','2';'3','4';'k','k'};

jcolumnname = {'ss','yy','zzz','x'};
jdata = {'1','2','5',false;'3','4',int8(7),true};

jt = JTable(jdata,jcolumnname);
% jt = javaObjectEDT('javax.swing.JTable');
% numel(methods(jt))

jt.getModel().setValueAt('newval', 1, 1);
jt.setAutoCreateRowSorter(true);

jjt = javacomponent(jt,[10 10 400 200],f);


%% Customizing uitable
import javax.swing.*
import java.awt.*

f = figure;
% https://undocumentedmatlab.com/blog/uitable-sorting
%   "New uitable sorting"

mtable = uitable(f, 'Data',rand(3), 'ColumnName',{'<html><b>A', '<html><b>B', '<html><b>C'});
mtable.Units = 'normalized';
mtable.Position = [0.1 0.1 0.5 0.5];
mtable.RowStriping = 'off';

jscrollpane = findjobj(mtable);

jtable = jscrollpane.getViewport.getView;
% uiinspect(jtable);
% size(methods(jtable))

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
jtable.setShowVerticalLines(false);

mtable.ColumnEditable = [false,true,false];

% data = mat2cell(int8(magic(3)) , [1,1,1] , [1,1,1] ); % {8,1,6; 3,5,7; 4,9,2} 
% cols = { '<html><b>A', 'B', 'C' };
% jtable.setModel(javax.swing.table.DefaultTableModel(data,cols));
% jtable.setBackground(java.awt.Color.cyan);
jtable.setDisabledBackground(Color.red);
% jtable.setScrollRowWhenRowHeightChanges(true);


% The lines below do not work
% gtable = mtable.getTable;
% cr = javax.swing.table.DefaultTableCellRenderer;
% cr.setForeground(java.awt.Color.red);
% gtable.getColumnModel.getColumn(1).setCellRenderer(cr); % 1=B 
% gtable.repaint; % repaint the table to use the new CellRenderer 



% mtable.Data = rand(3);

