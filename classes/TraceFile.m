classdef TraceFile < handle    
    properties
        fullpath
        dir
        name
        ext
        info
        entity
%         samples
%         cryptodata
    end

    methods
        function obj = TraceFile(fullpath)
            obj.fullpath = fullpath;
            [obj.dir, obj.name, obj.ext] = fileparts(fullpath);
            obj.info = get_trs_info(fullpath);
            if isequal(obj.ext,'.mat')
                obj.entity = matfile(fullpath);
%                 obj.samples = tmp.trs_sample;
%                 obj.cryptodata = tmp.trs_data;
            end
        end
    end
    
end

