function import_file(src,event,table_files)
    global file_pointer file_info;
    [filename, pathname, ~] = uigetfile( ...
        {...   
        '*.mat;*.trs','所有数据类型';...
        '*.mat','MAT 格式 (*.mat)'; ...
        '*.trs','trs 格式 (*.trs)'; ...
        '*.*',  '所有文件 (*.*)'}, ...
        '选择文件', ...
        'MultiSelect', 'on');

    % If cancel the open window, filename and pathname will be 0 (double);
    if isequal(filename, 0)
        return ;
    end
    % > Later I will check whether one file has been imported,
    % >   and ask the user whether to overwrite it if it has.
    if isequal(class(filename),'char')
        % Only one file,  type is 'char'
        % Multiple files, type is 'cell'
        % So I add curly braces to unify it.
        filename = {filename};
    end
    % `pathname` has a backslash (\)
    % `path_part` do not have a backslash (\) at the end,
    % So I use `pathname` here to avoid unforeseen problems.
    % Of course you can use fullfile() or filesep().

    for i = 1:numel(filename)
        full_name = [pathname filename{i}];
        [path_part,name_part,ext_part] = fileparts(full_name);
        file_pointer(end+1,1:4) = {false,name_part,ext_part,pathname};
        file_info{end+1,1} = get_trs_info(full_name);
    end
    
    set(table_files,'Data',file_pointer);
end
