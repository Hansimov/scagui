function convertToMat(~,~,obj)
    trs_fullname = obj.fullpath;
    [mat_filename,mat_dirname] = uiputfile('*.mat', '����Ϊ...',[obj.dir filesep obj.name]);
    if mat_filename ~= 0
        mat_fullname = [mat_dirname, mat_filename];
    else
        return;
    end
    [~,canceled] = trs2mat(trs_fullname, mat_fullname);
    if ~canceled
        file_open_choice = questdlg('�ļ�����ɹ����Ƿ�������д򿪣�', '', ...
            '��','��','��');
        switch file_open_choice
            case '��'
                global vars;
                vars.files{end+1} = TraceFile(mat_fullname);
            case '��'
            otherwise
        end
    end
end