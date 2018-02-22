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
            obj.attachListenners();
            
            jCloseButton = obj.createCloseIcon();
            obj.createJPanel();
            obj.addCloseIcon(jCloseButton);
%             obj.createSpinner();
%             obj.createPlots();
        end
    end
    
    methods (Access = private)
        function attachListenners(obj)
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
            global container;
            obj.index = numel(container.tabs)+1;
            obj.panel = javax.swing.JPanel; % default layout = FlowLayout
            set(obj.panel.getLayout, 'Hgap',5, 'Vgap',0);  % default gap = 5px
            jLabel = javax.swing.JLabel(obj.m.Title);
            obj.panel.add(jLabel);
        end
        
        function addCloseIcon(obj,jCloseButton)
            global container;
            obj.panel.add(jCloseButton);
            jTabGroup = findjobj('class','JTabbedPane','persist');
            jTabGroup.setTabComponentAt(numel(container.tabs),obj.panel);
            % Why I do not use numel(container.tabs)-1? 
            % Because current Xuitab object has not been added to the container.tabs.
        end
        
        function createPlots(obj,src,data)
            obj.plots = Plots(obj);
        end
        
    end
    
end


function closeTab(src,event,obj)
    current_tab_index = obj.index;
    
    global container;
    
    updateTabIndex(current_tab_index); 
    % The line above should be over the two lines below.
    % If the cell element which represents the current tab is assign empty first,
    %   update tab index should begin from current_tab_index, instead of current_tab_index+1
%     container.panels(current_tab_index) = [];
    container.tabs(current_tab_index) = [];
    delete(obj.m);
    delete(obj);
end

function updateTabIndex(current_tab_index)
    global container;
    for i = current_tab_index+1 : numel(container.tabs)
        container.tabs{i}.index = container.tabs{i}.index - 1;
    end
end




