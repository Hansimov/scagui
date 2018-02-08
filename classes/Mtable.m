% https://stackoverflow.com/a/16323036/8328786s
% A workaround to subclass Handle Graphics classes
%
% It is not hard to put .m and .j methods together,
%   but I still seperate the matlab handle and java handle,
%   because this keeps the struct clearer.
classdef Mtable < handle
    properties
        m % matlab handle
        j % java   handle
    end
    
    methods
        function obj = Mtable(varargin)
            obj.m = uitable(varargin{:});
            jscrollpane = findjobj(obj.m);
            obj.j = jscrollpane.getViewport.getView;
            obj = initialize(obj);
        end
        
        function obj = initialize(obj)
            obj.m.RowStriping = 'off';
%             obj.j.setAutoResizeMode(true);   % true: resize; false:show scrollbar
%             When sortable, indices of selected cel should be updated,
%               or I may use another method to represent the file object,
%               but currently I do not have time to implement this.
%             obj.j.setSortable(true);		 % When true, Header is bigger
%             obj.j.setSortingEnabled(true);   % Only both true, can be sorted
%             obj.j.setAutoResort(true);       % Auto update when choose another header
%             obj.j.setMultiColumnSortable(true);
%             obj.j.setPreserveSelectionsAfterSorting(true);
%             obj.j.setShowSortOrderNumber(true);
            
            % Effects of these properties are unknown.
%             obj.j.setColumnResizable(true); 
%             obj.j.setAutoscrolls(true);
%             obj.j.setColumnAutoResizable(true);
%             obj.j.setDragEnabled(true);
%             obj.j.sizeColumnsToFit(false);
        end

        function setColumnChar(obj)
            colNum = obj.j.getColumnCount();
            obj.m.ColumnFormat = repmat({'char'},1,colNum);
        end
        function setColumnAlignment(obj,alignType,varargin)
            if nargin == 2
                disp(nargin);
            else
                celldisp(varargin);
            end
        end
    end
    
end

