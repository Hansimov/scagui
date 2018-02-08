function trs_info = get_trs_info(trs_file)
    [path_part,name_part,ext_part] = fileparts(trs_file);
    if isequal(ext_part,'.trs')
        fid = fopen(trs_file,'r'); 
        % I don't bother to check if fid < 0.
        info_cell = struct2cell(read_header(fid));
        trs_info = reconstruct_cell(info_cell);
        fclose(fid);
    elseif isequal(ext_part,'.mat')
        mf = matfile(trs_file);
        if isprop(mf,'trs_info')  % .mat files saved by scagui
            info_cell = struct2cell(mf.trs_info);
            trs_info = reconstruct_cell(info_cell);
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

function cell_out = reconstruct_cell(cell_in)
    % We get a [14 x 1] cell, and each element is a [1 x 2] cell
    % What we want is a [14 x 2] cell
    row = size(cell_in,1);
    col = size(cell_in{1},2);
    cell_out = cell(row,col);
    for i = 1:row
        for j = 1:col
            cell_out{i,j} = cell_in{i}{j};
        end
    end
end