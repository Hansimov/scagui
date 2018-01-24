function trs_info = get_trs_info(trs_file)

    fid = fopen(trs_file,'r');

    if fid < 0
        disp('Open file error!');
        return
    end

    trs_info = struct2cell(read_header(fid));

    fclose(fid);
end