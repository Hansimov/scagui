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
            xuitab.type
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
            [obj.jspinner, obj.mspinner] = createSpinner(obj.ax,xuitab);
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
    sm = javax.swing.SpinnerNumberModel(2,1,trace_num,1); % default, min, max, step
    % Why I set the default as 2?
    % Because I want to update the plot directly when it is created.
    % To implement this, I set the default value 2 back to 1.
    js = javax.swing.JSpinner(sm);
    [jspinner, mspinner] = javacomponent(js);
    current_tab = xuitab.m;
    mspinner.Parent = current_tab;
    tabpos = getpixelposition(xuitab.m);
    mspinner.Position = [tabpos(3)*0.85 tabpos(4)*0.95 60 20];

    set(current_tab,'SizeChangedFcn', {@updateSpinnerPosition, mspinner});
    set(jspinner,'StateChangedCallback',{@updatePlots,ax,xuitab});
    jspinner.setValue(1); 
end


function updateSpinnerPosition(current_tab, event, mspinner)
    tabpos = getpixelposition(current_tab);
    mspinner.Position = [tabpos(3)*0.85 tabpos(4)*0.95 60 20];    
end

function updatePlots(src, data, ax, xuitab)
%     global vars;
    current_trace_index = src.getValue;
%     current_file_index = xuitab.file.index;
    plot(ax,cell2mat(xuitab.file.entity.trs_sample(current_trace_index,1)));
end


