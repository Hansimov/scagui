function trs_info = getTrsInfo(fullpath)
    [path_part,name_part,ext_part] = fileparts(fullpath);
    if isequal(ext_part,'.trs')
        fid = fopen(fullpath,'r'); 
        % I don't bother to check if fid < 0.
        info_cell = struct2cell(readHeader(fid));
        trs_info = reconstructCell(info_cell);
        fclose(fid);
    elseif isequal(ext_part,'.mat')
        mf = matfile(fullpath);
        if isprop(mf,'trs_info')  % .mat files saved by scagui
            info_cell = struct2cell(mf.trs_info);
            trs_info = reconstructCell(info_cell);
        elseif isprop(mf,'trace') % .mat files saved by SCAnalyzer
            % size() may take a lot of time
            % So I recommend use scagui instead of SCAnalyzer
            import_bar = waitbar(1,'该 .mat 文件由 SCAnalyzer 生成，需要一些解析时间，请稍等 ...');
            trs_info = {'Number of Traces', size(mf.trace,1); ...
                        'Number of Samples',size(mf.trace,2); ...
                        'Data Size',        size(mf.data, 2)};
            delete(import_bar);
        end
    end 
end