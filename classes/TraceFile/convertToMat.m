function convertToMat(~,~,obj)
    trs_fullname = obj.fullpath;
    [mat_filename,mat_dirname] = uiputfile('*.mat', '保存为...',[obj.dir filesep obj.name]);
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
                vars.files{end+1} = TraceFile(mat_fullname);
            case '否'
            otherwise
        end
    end
end