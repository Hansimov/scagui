classdef TraceFile < handle
properties (SetObservable, AbortSet)
    fullpath = '';
    dir = '';
    name = '';
    ext = '';
    info          % ? x 2 Cell
    trs_info      % Struct
    trs_data      % ? x 1 Cell
    trs_sample    % ? x 1 Cell
    entity        % Linked to matfile
    trace_num     
    sample_num
%     index         % Row number in the table_files
    status        % isDownsampled, isLowpassed, isAligned, isAttacked
end

methods
    function obj = TraceFile(varargin)
        if isempty(varargin)
        else
            fullpath = varargin{1};
            obj.entitize(fullpath);
        end
        obj.addListeners;
        obj.createStatus;
    end
    
    function entitize(obj,fullpath)
        obj.fullpath = fullpath;
        [obj.dir, obj.name, obj.ext] = fileparts(fullpath);
        if isequal(obj.ext,'.mat')
            obj.entity = matfile(fullpath);
            obj.trs_info = obj.entity.trs_info;
            obj.trs_data = obj.entity.trs_data;
            obj.trs_sample = obj.entity.trs_sample;
            obj.trace_num = obj.trs_info.nt{2};
            obj.sample_num = obj.trs_info.ns{2};
        end
        obj.info = getTrsInfo(fullpath);
    end
    
    function addListeners(obj)
        addlistener(obj,'trs_info','PostSet',@obj.updateTrsinfo);
    end

    function updateTrsinfo(obj,~,~)
        obj.info = reconstructCell(struct2cell(obj.trs_info));
        obj.trace_num = obj.trs_info.nt{2};
        obj.sample_num = obj.trs_info.ns{2};
    end
end

methods
    function createContextMenu(obj,ctmenu)
        if strcmp(obj.ext,'.trs')
            uimenu(ctmenu,'Label','转换成 .mat 格式','Callback',@obj.convertToMat);
        else
            menu.viewFile = uimenu(ctmenu,'Label','查看曲线','Callback',@obj.viewFile);
            menu.viewFreq = uimenu(ctmenu,'Label','查看频谱','Callback',@obj.viewFreq);
%             menu.view.Separator = 'on';
            menu.downsample = uimenu(ctmenu,'Label','降采样','Callback',@obj.downsample);
            menu.downsample.Separator = 'on';
            uimenu(ctmenu,'Label','低通','Callback',@obj.lowpass);
            uimenu(ctmenu,'Label','对齐','Callback',@obj.align);
            menu.attack = uimenu(ctmenu,'Label','攻击','Callback',@obj.attack);
%             uimenu(menu.attack,'Label','AES');
            if strcmp(obj.ext,'')
                menu.savetomat = uimenu(ctmenu,'Label','保存为 .mat 格式','Callback',@obj.saveToMat);
                menu.savetomat.Separator = 'on';
            end
        end
        menu.delete = uimenu(ctmenu,'Label','删除对象','Callback',@deleteFile);
        menu.delete.ForegroundColor = 'red';
        menu.delete.Separator = 'on';
        menu.delete.Checked = 'on';
    end
    
    function createStatus(obj)
        status_cell = {'isDownsampled','isLowpassed','isAligned','isAttacked'};
        for i = 1:numel(status_cell)
            if ~isfield(obj.status, status_cell{i})
                eval(['obj.status.' status_cell{i} '= false;'])
            end
        end
    end
end

methods
    function obj_copy = copy(obj)
        obj_copy = TraceFile();
        obj_copy_props = properties('TraceFile');
        
        props_not_copied = {'fullpath','ext','entity'};
        for i = 1:numel(obj_copy_props)
            if ~ismember(obj_copy_props{i},props_not_copied)
                eval(['obj_copy.' obj_copy_props{i} '= obj.' obj_copy_props{i} ';']);
            end
        end
    end
    
    function saveToMat(obj)
        disp('saved!');
    end
end

% methods
%     function sample_out = lowpass(obj,~,~,cutoff_freq)
%     end
%     
%     function sample_out = align(obj,~,~,base_trace)
%     end
% end

methods
    convertToMat(obj,~,~)
    viewFile(obj,~,~)
    
    downsample(obj,~,~)
    lowpass(obj,~,~)
    viewFreq(obj,~,~)


% function deleteFile(~,~)
%     global vars;
%     vars.files(row,:) = [];
%     vars.file_pointers(row,:) = [];
%     set(table_of_traceinfo,'Data',{});
%     set(table_src, 'Data', vars.file_pointers);
% end

end

end





