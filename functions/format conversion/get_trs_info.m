function trs_info = get_trs_info(trs_file)

    fid = fopen(trs_file,'r');

    if fid < 0
        disp('Open file error!');
        return
    end

    trs_info = read_header(fid);

    m = dec2hex(fread(fid,320,'uint8'),2);
    m'
    fclose(fid);
end