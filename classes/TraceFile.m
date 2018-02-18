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
            obj.info = getTrsInfo(fullpath);
            if isequal(obj.ext,'.mat')
                obj.entity = matfile(fullpath);
%                 obj.samples = tmp.trs_sample;
%                 obj.cryptodata = tmp.trs_data;
            end
        end
        function sample_out = downsample(obj,down_rate)
            sample_vec = cell2mat(obj.entity.trs_sample(1,1));
            sample_out = downSample(sample_vec,down_rate);
        end
    end
    
end

