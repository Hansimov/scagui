classdef GlobalContainer < handle
% This function is to wrap the global variables.
    properties (SetObservable, AbortSet)
        file_pointers = {};
        file_info = {};
        panels = {};
        tabs = {};
        traces_original = {};
        traces_downsample = {};
        traces_filter = {};
        current_file = {};
        current_tab = {};
        current_trace = {};
    end
    
    methods
        function obj = GlobalContainer()
            obj.attachListener;
        end
    end
    
    methods
        function attachListener(obj)
            addlistener(obj,'type','PostSet',@Containers.updateType);
        end
    end
    
    methods (Static)
        function updateType(src,data)
            obj = data.AffectedObject;
%             propName = src.Name;
            type = obj.type;                    
        end
    
    end
end



