classdef Plots < handle
% This class is to show results of different processing stages
    properties
        type
        tab
        jspinner
        mspinner
        ax
    end
    
    methods
        function obj = Plots(xuitab)
            obj.tab = xuitab;
%             xuitab.type
            switch lower(xuitab.type)
                case 'original'
                    obj.plotOriginalTrace();
                case 'downsample'
                    obj.plotDownsampledTrace();
                case 'lowpass'
                    obj.plotLowpassedTrace();
                case 'align'
                    obj.plotAlignedTrace();
                case 'attack'
                    obj.plotAttackProgress();
            end
        end
        
        function plotOriginalTrace(obj)
            xuitab = obj.tab;
            obj.ax = axes(xuitab.m);
            [obj.jspinner, obj.mspinner] = createSpinner(obj.ax, xuitab);
        end
        
        function plotDownsampledTrace(obj)
        end
        function plotLowpassedTrace(obj)
        end
        function plotAlignedTrace(obj)
        end
        function plotAttackProgress(obj)
        end
    end
    
end

function [jspinner,mspinner] = createSpinner(ax,xuitab)
    trace_num = xuitab.file.trace_num;
    sm = javax.swing.SpinnerNumberModel(1,1,trace_num,1); 
    % default, min, max, step
    js = javax.swing.JSpinner(sm);
    [jspinner, mspinner] = javacomponent(js);
    current_tab = xuitab.m;
    mspinner.Parent = current_tab;
    tabpos = getpixelposition(xuitab.m);
    mspinner.Position = [tabpos(3)*0.85 tabpos(4)*0.95 60 20];

    set(current_tab,'SizeChangedFcn', {@updateSpinnerPosition, mspinner});
    set(jspinner,'StateChangedCallback',{@updatePlots,ax,xuitab});
    updatePlots(jspinner, ax, xuitab);
end


function updateSpinnerPosition(current_tab, event, mspinner)
    tabpos = getpixelposition(current_tab);
    mspinner.Position = [tabpos(3)*0.85 tabpos(4)*0.95 60 20];    
end

function updatePlots(varargin)
% [src, data,] ax, xuitab
    if nargin == 3
        src = varargin{1};
        ax = varargin{2};
        xuitab = varargin{3};
    elseif nargin == 4
        src = varargin{1};
        ax = varargin{3};
        xuitab = varargin{4};
    end
    current_trace_index = src.getValue;
    plot(ax,cell2mat(xuitab.file.trs_sample(current_trace_index,1)));
    ax.XLim = [0 inf];
end


