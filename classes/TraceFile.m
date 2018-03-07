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
end

methods
    function createContextMenu(obj,ctmenu)
        if strcmp(obj.ext,'.trs')
            uimenu(ctmenu,'Label','转换成 .mat 格式','Callback',@obj.convertToMat);
        end
        if strcmp(obj.ext,'.mat')
            uimenu(ctmenu,'Label','查看曲线','Callback',@obj.viewFile);
        end
        uimenu(ctmenu,'Label','删除对象','Callback',@deleteFile);
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

methods 
    function obj_new = copy(obj)
        
    end
end

methods
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
end

methods
function convertToMat(obj,~,~)
    trs_fullname = obj.fullpath;
    [mat_filename,mat_dirname] = uiputfile('*.mat', '保存为...',[path_part filesep name_part]);
    if mat_filename ~= 0
        mat_fullname = [mat_dirname, mat_filename];
    else
        return;
    end
     [~,canceled] = trs2mat(trs_fullname, mat_fullname);
     if ~canceled
         file_open_choice = questdlg('文件保存成功，是否在软件中打开？', '', ...
                                    '是','否','是');
         switch file_open_choice
             case '是'
                 global vars;
                 [mat_dir_part, mat_name_part, mat_ext_part] = fileparts(mat_fullname);
%                  vars.fileinfo(end+1,1:3) = {false, mat_name_part, mat_ext_part};
                 vars.files{end+1,1} = TraceFile(mat_fullname);
             case '否'
             otherwise
         end
     end
end

function viewFile(obj,~,~)
    global vars comps;
    vars.tabs{end+1} = Xuitab(comps.tabgroup.plots,'Title',num2str(numel(vars.tabs)));
    vars.tabs{end}.file = obj; % This line should be put before the below.
    vars.tabs{end}.type = 'original';
end

function deleteFile(~,~)
    global vars;
    vars.files(row,:) = [];
    vars.file_pointers(row,:) = [];
    set(table_of_traceinfo,'Data',{});
    set(table_src, 'Data', vars.file_pointers);
end
    
end

end






