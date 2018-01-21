function mat_file = trs2mat(trs_file)
% FormatConversion() is more likely a function name, but I follow the MATLAB naming styles.
% This function convert *.trs to *.mat:
%   - Return basic infomation of the traces
%     - Number of Traces
%     - Number of Samples (per trace)
%     - Sample Coding: int/float, sample size (1, 2, 4 bytes)
%     - Data Size: Cryptographic data (plaintext) in bytes (by default)
%     - Title String
%     - X,Y axes Label
%     - X,Y axes Scale
%   - Plaintext data
%   - Sample points
%
% *.mat: matlab files storing data, here I choose version '-v7.3'
% *.trs: trace files collected by the hardwares: PowerRecorder/EMRecorder
% A typical format of *.trs is TLV: Tag + Length + Value

    fid = fopen(trs_file,'r');

    if fid < 0
        disp('Open file error!');
        return
    end

    trs_info = read_header(fid)

    % dec2hex(fread(fid,1,'uint8'),2)
    

    fclose(fid);


end

