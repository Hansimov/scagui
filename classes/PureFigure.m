classdef PureFigure < handle

properties
    m
end

methods 
    function obj = PureFigure()
    obj.m = figure;
    obj.m.MenuBar = 'None';
    obj.m.NumberTitle = 'off';
    end
end
    
end

