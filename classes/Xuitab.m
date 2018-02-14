classdef Xuitab < handle
% https://undocumentedmatlab.com/blog/tab-panels-uitab-and-relatives
% https://undocumentedmatlab.com/blog/uitab-customizations
% https://undocumentedmatlab.com/blog/uitab-colors-icons-images    
    properties
        m
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
            
            set(jCloseButton, 'ActionPerformedCallback',{@close_tab,obj});
            global jPanel;
            jPanel{end+1,1} = javax.swing.JPanel;	% default layout = FlowLayout
            set(jPanel{end}.getLayout, 'Hgap',0, 'Vgap',0);  % default gap = 5px
            jLabel = javax.swing.JLabel(obj.m.Title);
            jPanel{end}.add(jLabel);
            jPanel{end}.add(jCloseButton);
%             global jTabGroup;
            jTabGroup = findjobj('class','JTabbedPane','persist');
            jTabGroup.setTabComponentAt(numel(jPanel)-1,jPanel{end});
            
        end
    end
    
end

function close_tab(src,event,obj)
    disp(obj);
    delete(obj.m);
    delete(obj);
end

