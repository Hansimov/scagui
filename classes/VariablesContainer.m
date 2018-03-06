classdef VariablesContainer < handle
% This class is to wrap the global variables.
properties (SetObservable, AbortSet)
    fileinfo = {};
    files = {};
    tabs = {};
%     traces = {}; % Contain traces processed
    tabgroup
%     current_file;
%     current_tab;
%     current_trace;        
end
    
methods
    function obj = GlobalContainer()
        obj.addListeners;
    end
end
    
methods
    function addListeners(obj)
        addlistener(obj,'files','PostSet',@obj.updateFileinfo);
        %             addlistener(obj,'tabs','PostSet',@Containers.updateType);
    end
    function updateFileinfo(obj)
        obj.fileinfo
    end
end

%     methods (Static)
%         function updateType(src,data)      
%         end
%     end
end



