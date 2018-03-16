function test_dragline()
import javax.swing.*
fig = figure;
ax = axes(fig);
ax.XLim = [0 3];
myline = line(ax,'XData',[1 1],'YData',ax.YLim);
myline.XData = 2 * [1 1];

fig.WindowButtonMotionFcn = @detectPointer;
clicked = false;

% ^^^
% Why I put `clicked` outside the detectPointer?
% Because if I do not, 
%   when coordinates of the pointer change,
%   although the WindowButtonDownFcn will be executed,
%   it will wait for the return of `detectPointer`,
%   while the clicked is still false.
% And this also explains why the line will not update its x coordinate
%   when you click the valid region the first time.

% This line disable warnings when using tools like zoom or pan.
% D:\MATLAB R2017a\toolbox\matlab\uitools\+matlab\+uitools\+internal\@uimodemanager\uimodemanager.m
warning('off','MATLAB:modes:mode:InvalidPropertySet');
% When you are using tools like zoom or pan,
%   the class of figure's WindowButtonDownFcn is a [3x1] 'cell'
% if the user assigns a callback to the WindowButtonDownFcn,
%   the class of is 'function_handle'
% The default class of WindowButtonDownFcn is '', which is 'char'

jsp = JSpinner(SpinnerNumberModel(1,0,3,0.01));
javacomponent(jsp);
set(jsp,'StateChangedCallback',{@updateLine,myline});
jsp.setValue(2);

% set(gcf,'Renderer','painters');
% set(gcf,'GraphicsSmoothing','off');

    function detectPointer(src,data)
        px = ax.CurrentPoint(1,1);
        py = ax.CurrentPoint(1,2);
        lx = myline.XData;
        ly = myline.YData;
        ax_pos = getpixelposition(ax);
        ax_width_pix = ax_pos(3);
        ax_width_num = ax.XLim(2) - ax.XLim(1);
        margin = 20*ax_width_num/ax_width_pix;
%         findall(gcf,'class','matlab.uitools.internal.uimodemanager')
%         findall(gcf,'class','uimodemanager')
        if (lx(1)-margin <= px) && (px <= lx(1)+margin) ...
                && (ly(1) <= py) && (py <= ly(2))
            if ~strcmp(class(fig.WindowButtonDownFcn),'cell')
                set(fig,'pointer','left');
            end
            fig.WindowButtonDownFcn = @setClickedTrue;
            fig.WindowButtonUpFcn =   @setClickedFalse;
        elseif ~clicked
            if ~strcmp(class(fig.WindowButtonDownFcn),'cell')
                set(fig,'pointer','arrow');
            end
            fig.WindowButtonDownFcn = @setClickedFalse;
            fig.WindowButtonUpFcn =   @setClickedFalse;
        end
        
        if clicked
            if px <= ax.XLim(1)
                px = ax.XLim(1);
            end
            if px >= ax.XLim(2)
                px = ax.XLim(2);
            end
%             px = round(px,2);
            myline.XData = px * [1 1];
            myline.YData = ax.YLim;
            jsp.setValue(px);
        else
%                 disp('Not Clicked');
        end
        
        function setClickedTrue(~,~)
            clicked = true;
        end
        function setClickedFalse(~,~)
            clicked = false;
        end
    end
end

function updateLine(src,data,myline)
    x = src.getValue;
    myline.XData = x * [1 1];
end