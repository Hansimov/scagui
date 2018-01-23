function import_file(src,event,table_files)
global file_info;
[filename, pathname, ~] = uigetfile( ...
    {...   
    '*.mat;*.trs','所有数据类型';...
    '*.mat','MAT 格式 (*.mat)'; ...
    '*.trs','trs 格式 (*.trs)'; ...
    '*.*',  '所有文件 (*.*)'}, ...
    '选择文件', ...
    'MultiSelect', 'on');

full_name = [pathname filename];

% If cancel the open window, filename and pathname will be 0 (double);
if filename ~= 0
%     m = matfile([pathname filename]);
%     assignin('base', prename, m);
    % Notes: `path_part` do not have a backslash (\) at the end,
    %        while `pathname` has a backslash (\)
    %        So I use `pathname` here to avoid unforeseen problems.
    % Of course you can use fullfile() or filesep().
    [path_part,name_part,ext_part] = fileparts(full_name);
    % > Later I will check whether one file has been imported,
    % >   and ask the user whether to overwrite it if it has.
    file_info(end+1,1:3) = {name_part,ext_part,pathname};
    set(table_files,'Data',file_info);
else
end
end