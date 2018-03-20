function importFile(~,~)
    global vars;
    [filename, dirname, ~] = uigetfile( { '*.mat;*.trs','������������';...
                                           '*.mat','MAT ��ʽ (*.mat)'; ...
                                           '*.trs','trs ��ʽ (*.trs)'; ...
                                           '*.*',  '�����ļ� (*.*)'}, ...
                                           'ѡ���ļ�', ...
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
    
    % `pathname` has a backslash (\) at the end,
    % `dir_part` does not have a backslash (\)
    % So I use `pathname` here to avoid unforeseen problems.
    % Of course you can use fullfile() or filesep().
    wait_bar = waitbar(0.98,'���ڵ������ߣ����Ե� ...');
    for i = 1:numel(filename)
        fullpath = [dirname filename{i}];
%         [dir_part,name_part,ext_part] = fileparts(fullpath);
        vars.files{end+1} = TraceFile(fullpath);
%         vars.files{end}.index = numel(vars.files);
    end
    delete(wait_bar);

end
