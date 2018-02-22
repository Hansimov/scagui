classdef GlobalContainer < handle
% This class is to wrap the global variables.
    properties (SetObservable, AbortSet)
        file_pointers = {};
        files = {};
        tabs = {};
        traces_original = {};
        traces_downsample = {};
        traces_filter = {};
        tabgroup
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
%             addlistener(obj,'tabs','PostSet',@Containers.updateType);
        end
    end
    
%     methods (Static)
%         function updateType(src,data)      
%         end
%     end
end



