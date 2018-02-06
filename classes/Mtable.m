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
            obj.j.setSortable(true);		% or: set(jtable,'Sortable','on');
            obj.j.setAutoResort(true);
            obj.j.setMultiColumnSortable(true);
            obj.j.setPreserveSelectionsAfterSorting(true);
            obj.j.setAutoResizeMode(true);
            obj.j.setShowSortOrderNumber(true);
            obj.j.setColumnResizable(true);
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

