function [trs_info] = get_trs_info(trs_file)

    fid = fopen(trs_file,'r');

    if fid < 0
        disp('Open file error!');
        return
    end

    trs_info = read_header(fid)

    dec2hex(fread(fid,1,'uint8'),2)
    

    fclose(fid);
end