function trs_info = get_trs_info(trs_file)

    fid = fopen(trs_file,'r');

    if fid < 0
        disp('Open file error!');
        return
    end
    % We get a [14 x 1] cell, and each element is a [1 x 2] cell
    info_cell = struct2cell(read_header(fid));
    % What we want is a [14 x 2] cell
    row = size(info_cell,1);
    col = size(info_cell{1},2);
    trs_info = cell(row,col);
    for i = 1:row
        for j = 1:col
            trs_info{i,j} = info_cell{i}{j};
        end
    end
    fclose(fid);
end