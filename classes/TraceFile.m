classdef TraceFile < handle    
    properties
        fullpath
        dir
        name
        ext
        info          % Cell type
        trs_info      % Struct type
        entity
        trace_num
        sample_num
        index         % Row number in the table_files
        status        % isDownsampled, isLowpassed, isAligned
    end

    methods
        function obj = TraceFile(fullpath)
            obj.fullpath = fullpath;
            [obj.dir, obj.name, obj.ext] = fileparts(fullpath);
            obj.info = getTrsInfo(fullpath);
            if isequal(obj.ext,'.mat')
                obj.entity = matfile(fullpath);
            end
            obj.trs_info = obj.entity.trs_info;
            obj.trace_num = obj.trs_info.nt{2};
            obj.sample_num = obj.trs_info.ns{2};
            obj.createStatus();
        end
        function sample_out = downsample(obj,down_rate)
%             trace_num = obj.info.nt{2};
            sample_out = {};
            for i = 1:obj.trace_num
                sample_vec = cell2mat(obj.entity.trs_sample(1,1));
                sample_out{i} = downSample(sample_vec,down_rate);
            end
        end
        function sample_out = lowpass(obj,cutoff_freq)
        end
        function sample_out = align(obj,base_trace)
        end
        function createStatus(obj)
            status_cell = {'isDownsampled','isLowpassed','isAligned'};
            for i = 1:3
                if ~isfield(obj.status,status_cell{i})
                    eval(['obj.status.' status_cell{i} '= false;'])
                end
            end
        end
    end
    
end

