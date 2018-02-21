classdef Xuitab < handle
% https://undocumentedmatlab.com/blog/tab-panels-uitab-and-relatives
% https://undocumentedmatlab.com/blog/uitab-customizations
% https://undocumentedmatlab.com/blog/uitab-colors-icons-images
% https://docs.oracle.com/javase/tutorial/uiswing/components/tabbedpane.html
% https://docs.oracle.com/javase/7/docs/api/javax/swing/JTabbedPane.html
    properties (SetObservable, AbortSet)
        m
        index
        type
        panel
        axes
    end
    
    methods
        function obj = Xuitab(varargin)
            obj.m = uitab(varargin{:});
            obj.attachListenners();
       
            jCloseButton = obj.createCloseIcon();
            obj.createJPanel();
            obj.addCloseIcon(jCloseButton);
            obj.createSpinner();
        end

    end
    
    methods (Access = private)
        function attachListenners(obj)
            addlistener(obj,'type','PostSet',@obj.updateType);
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
            numel(container.tabs)
            jTabGroup.setTabComponentAt(numel(container.tabs),obj.panel);
            % Why I do not use numel(container.tabs)-1? 
            % Because current Xuitab object has not been added to the container.tabs.
        end
        
        function createSpinner(obj)
            sm = javax.swing.SpinnerNumberModel(1,1,100,1); % default, min, max, step
            js = javax.swing.JSpinner(sm);
            [jspinner, mspinner] = javacomponent(js);
            current_tab = obj.m;
            mspinner.Parent = current_tab;
            tabpos = getpixelposition(obj.m);
            mspinner.Position = [tabpos(3)*0.85 tabpos(4)*0.95 60 20];
            current_tab.SizeChangedFcn = {@updateSpinnerPosition, mspinner};
            
            set(jspinner,'StateChangedCallback',{@updatePlotResult,obj.index});
        end
        
%         function createAxes(obj)
%             
%         end
        
    end
    
    methods % (Static)
        function updateType(obj,src,data)
%             disp(obj.type);
%             switch lower(src.type)
%                 case 'original'
%                     
%             end
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

function updateSpinnerPosition(current_tab,event,mspinner)
    tabpos = getpixelposition(current_tab);
    mspinner.Position = [tabpos(3)*0.85 tabpos(4)*0.95 60 20];    
end

function updatePlotResult(src,data,current_tab_index)
    current_trace_index = src.getValue
%     plotTrace(current_trace_index);
end

function plotTrace()
    
end

