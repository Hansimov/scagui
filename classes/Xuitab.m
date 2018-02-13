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
            disp('...')
            close_icon =  javax.swing.ImageIcon( ...
                'closebox.gif');
            jCloseButton = handle(javax.swing.JButton,'CallbackProperties');
            jCloseButton.setIcon(close_icon);
            jCloseButton.setPreferredSize(java.awt.Dimension(15,15));
            jCloseButton.setMaximumSize(java.awt.Dimension(15,15));
            jCloseButton.setSize(java.awt.Dimension(15,15));
            
            set(jCloseButton, 'ActionPerformedCallback',{@close_tab,obj});
            
            jPanel = javax.swing.JPanel;	% default layout = FlowLayout
            set(jPanel.getLayout, 'Hgap',0, 'Vgap',0);  % default gap = 5px
            jLabel = javax.swing.JLabel('My Tab');
            jPanel.add(jLabel);
            jPanel.add(jCloseButton);
            jTabGroup = findjobj('class','JTabbedPane');
            jTabGroup.setTabComponentAt(0,jPanel);
            
        end
    end
    
end

function close_tab(src,event,obj)
    disp(obj);
    delete(obj);
end

