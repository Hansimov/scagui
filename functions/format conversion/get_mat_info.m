function mat_info = get_mat_info(mat_file)
    mf = matfile(mat_file);
    if isprop(mf,'trs_info')
        % New version of saved mat-files
        mat_info = struct2cell(mf.trs_info);

    elseif isprop(mf,'data')
        % Old version of saved mat-files
        mat_info = {};
    end

end