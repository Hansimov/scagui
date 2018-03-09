classdef Xuitab < handle
% https://undocumentedmatlab.com/blog/tab-panels-uitab-and-relatives
% https://undocumentedmatlab.com/blog/uitab-customizations
% https://undocumentedmatlab.com/blog/uitab-colors-icons-images
% https://docs.oracle.com/javase/tutorial/uiswing/components/tabbedpane.html
% https://docs.oracle.com/javase/7/docs/api/javax/swing/JTabbedPane.html
    properties (SetObservable, AbortSet)
        m
        index
        panel
        plots
        type
        file % file related to the current xuitab
    end
    
    methods
        function obj = Xuitab(varargin)
            obj.m = uitab(varargin{:});
            obj.addListeners();
            
            jCloseButton = obj.createCloseIcon();
            obj.createJPanel();
            obj.addCloseIcon(jCloseButton);
        end
    end
    
    methods (Access = private)
        function addListeners(obj)
            addlistener(obj,'type','PostSet',@obj.createPlots);
        end
        
        function jCloseButton = createCloseIcon(obj)
            close_icon =  javax.swing.ImageIcon(which('closebox.gif'));
            jCloseButton = handle(javax.swing.JButton,'CallbackProperties');
            jCloseButton.setIcon(close_icon);
            jCloseButton.setPreferredSize(java.awt.Dimension(15,15));
            jCloseButton.setMaximumSize(java.awt.Dimension(15,15));
            jCloseButton.setSize(java.awt.Dimension(15,15));
            set(jCloseButton, 'ActionPerformedCallback',{@closeTab,obj});
        end
        
        function createJPanel(obj)
            global vars;
            obj.index = numel(vars.tabs)+1;
            obj.panel = javax.swing.JPanel; % default layout = FlowLayout
            set(obj.panel.getLayout, 'Hgap',5, 'Vgap',0);  % default gap = 5px
            jLabel = javax.swing.JLabel(obj.m.Title);
            obj.panel.add(jLabel);
        end
        
        function addCloseIcon(obj,jCloseButton)
            global comps vars;
            obj.panel.add(jCloseButton);
            jTabgroup = findjobj(comps.tabgroup.plots, 'class', 'JTabbedPane','persist');
            try
                jTabgroup = jTabgroup(end); % In case several handles are returned
            catch
                jTabgroup = findjobj(comps.tabgroup.plots, 'class', 'JTabbedPane','persist');
            end
%             https://undocumentedmatlab.com/blog/uitab-colors-icons-images#comment-342129
            % Without the line above, an error will sometimes happen:
            %   "Undefined function 'setTabComponentAt' for input arguments of type 'handle.handle'."
%                 obj.tabgroup.plots.pane = handle(jTabGroup,'CallbackProperties');
            % Why I do not use numel(vars.tabs)-1?
            % Because current Xuitab object has not been added to the container.tabs.
            jTabgroup.setTabComponentAt(numel(vars.tabs), obj.panel);
        end
        
        function createPlots(obj,src,data)
            obj.plots = Plots(obj);
        end
        
    end
    
end


function closeTab(src, event, obj)
    current_tab_index = obj.index;
    global vars;    
    updateTabIndex(current_tab_index); 
    % The line above should be over the two lines below.
    % If the cell element which represents the current tab is assign empty first,
    %   update tab index should begin from current_tab_index, instead of current_tab_index+1
    vars.tabs(current_tab_index) = [];
    delete(obj.m);
    delete(obj);
end

function updateTabIndex(current_tab_index)
    global vars;
    for i = current_tab_index+1 : numel(vars.tabs)
        vars.tabs{i}.index = vars.tabs{i}.index - 1;
    end
end




