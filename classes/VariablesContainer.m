classdef VariablesContainer < handle
% This class is to wrap the global variables.
properties (SetObservable, AbortSet)
    fileinfo = {};
    files = {};
    tabs = {};
%     traces = {}; % Contain traces processed
%     tabgroup
%     current_file;
%     current_tab;
%     current_trace;        
end
    
methods
    function obj = VariablesContainer()
        obj.addListeners;
    end
end

methods
    function addListeners(obj)
        addlistener(obj,'fileinfo','PostSet',@obj.updateFileinfo);
        addlistener(obj,'files','PostSet',@obj.updateFiles);
    end
    
    function updateFileinfo(obj,src,event)
        global comps;
        set(comps.table.fileinfo.m, 'Data', obj.fileinfo);
    end
    function updateFiles(obj,src,event)
        global vars;
        for i = 1:numel(vars.files)
            vars.fileinfo(i,1:3) = {false, vars.files{i}.name, vars.files{i}.ext};
        end
    end
end

end



