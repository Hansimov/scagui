classdef Xuitab < handle
% https://undocumentedmatlab.com/blog/tab-panels-uitab-and-relatives
% https://undocumentedmatlab.com/blog/uitab-customizations
% https://undocumentedmatlab.com/blog/uitab-colors-icons-images
% https://docs.oracle.com/javase/tutorial/uiswing/components/tabbedpane.html
% https://docs.oracle.com/javase/7/docs/api/javax/swing/JTabbedPane.html
    properties
        m
        index
    end
    
    methods
        function obj = Xuitab(varargin)
            obj.m = uitab(varargin{:});

            close_icon =  javax.swing.ImageIcon(which('closebox.gif'));
            jCloseButton = handle(javax.swing.JButton,'CallbackProperties');
            jCloseButton.setIcon(close_icon);
            jCloseButton.setPreferredSize(java.awt.Dimension(15,15));
            jCloseButton.setMaximumSize(java.awt.Dimension(15,15));
            jCloseButton.setSize(java.awt.Dimension(15,15));
            
            set(jCloseButton, 'ActionPerformedCallback',{@closeTab,obj});
            
            global panel_container;
            obj.index = numel(panel_container)+1;
            
            panel_container{end+1,1} = javax.swing.JPanel;	% default layout = FlowLayout
            set(panel_container{end}.getLayout, 'Hgap',5, 'Vgap',0);  % default gap = 5px
            jLabel = javax.swing.JLabel(obj.m.Title);
            panel_container{end}.add(jLabel);
            panel_container{end}.add(jCloseButton);
%             global jTabGroup;
            jTabGroup = findjobj('class','JTabbedPane','persist');
            jTabGroup.setTabComponentAt(numel(panel_container)-1,panel_container{end});
        end
    end
    
end

function closeTab(src,event,obj)
    current_tab_index = obj.index;
    
    global panel_container tab_container;
    
    updateTabIndex(current_tab_index); 
    % The line above should be over the two lines below.
    % If the cell element which represents the current tab is assign empty first,
    %   update tab index should begin from current_tab_index, instead of current_tab_index+1
    panel_container(current_tab_index) = [];
    tab_container(current_tab_index) = [];
    
    delete(obj.m);
    delete(obj);
end

function updateTabIndex(current_tab_index)
    global tab_container;
    for i = current_tab_index+1 : numel(tab_container)
        tab_container{i,1}.index = tab_container{i,1}.index - 1;
    end
end

