classdef TraceFile < handle    
    properties
        fullpath
        dir
        name
        ext
        info          % Cell type
        trs_info      % Struct type
        trs_data
        trs_samples
        entity
        trace_num
        sample_num
        index         % Row number in the table_files
        status        % isDownsampled, isLowpassed, isAligned
    end

    methods
        function obj = TraceFile(varargin)
            if isempty(varargin)
            else
                fullpath = varargin{1};
                obj.initialize(fullpath);
            end
            obj.createStatus();
        end
        
        function initialize(obj,fullpath)
            obj.fullpath = fullpath;
            [obj.dir, obj.name, obj.ext] = fileparts(fullpath);
            if isequal(obj.ext,'.mat')
                obj.entity = matfile(fullpath);
            end
            obj.info = getTrsInfo(fullpath);
            obj.trs_info = obj.entity.trs_info;
            obj.trace_num = obj.trs_info.nt{2};
            obj.sample_num = obj.trs_info.ns{2};

        end
        
        function createContextMenu(obj)
            disp('hellp');
        end
        
        function sample_out = downsample(obj,down_rate)
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
            for i = 1:numel(status_cell)
                if ~isfield(obj.status,status_cell{i})
                    eval(['obj.status.' status_cell{i} '= false;'])
                end
            end
        end
    end
    
end

