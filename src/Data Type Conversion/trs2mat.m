function [trs_info, canceled]= trs2mat(trs_filename, mat_filename)
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

    fid = fopen(trs_filename,'r');

    if fid < 0
        disp('Open file error!');
        return
    end

    trs_info = readHeader(fid);

    % dec2hex(fread(fid,1,'uint8'),2)
    trace_num   = trs_info.nt{2};
    sample_num  = trs_info.ns{2};
    data_size   = trs_info.ds{2};
    sample_type = trs_info.st{2};
%     sample_size = trs_info.ss{2};
    

%     % Sample Coding: (trs_info.sc)
%     %   0000 0001
%     %   bit 8-6   reserved, set to '000'
%     %   bit 5     integer (0) or floating point (1)
%     %   bit 4-1   Sample length in bytes (valid values are 1, 2, 4)
%     sample_coding = hex2bin(trs_info.sc{2});
%     sample_type   = sample_coding(4);
%     sample_size   = bin2dec(arr2str(sample_coding(5:8)));


    % Of course I can use the string type in MATLAB, but it only supports versions after R2016b.
    % So in order to be compatible with older versions, I still use cell type.
    trs_data   = cell(trace_num,1);
%     trs_sample = zeros(trace_num,sample_num);
    trs_sample = cell(trace_num,1);
    
    progress_bar = waitbar(0,'正在读取文件 ...','Name','文件格式转换', ...
            'CreateCancelBtn','setappdata(gcbf,''canceling'',1)');
    setappdata(progress_bar,'canceling',0);
    for i = 1:trace_num
        if getappdata(progress_bar,'canceling')
            break ;
        end
        waitbar(i/trace_num,progress_bar,sprintf('正在处理曲线： %05d / %05d',i,trace_num));
        trs_data{i}   = readData(fid,data_size);
        % Use () to assign values will convert its type to double,
        %   so I use {} to keep int8
        % Currently, this structure is most effecient.
%         trs_sample(i,:) = read_sample(fid,sample_num,sample_type,sample_size); 
        trs_sample{i} = readSample(fid,sample_num,sample_type);
    end
    
    canceled = getappdata(progress_bar,'canceling');
    % Use delete(), instead of close() !
    delete(progress_bar);
    
    if ~canceled
        save_bar = waitbar(1,'正在保存文件，请耐心等待 ...','Name','保存文件');
        save(mat_filename,'trs_info','trs_data','trs_sample','-v7.3');
        delete(save_bar);
    end
    
    fclose(fid);

end

function data = readData(fid,data_size)
    data = fread(fid,data_size,'uint8','b');
    data = dec2hex(data,2);
    data = num2cell(data);      % Seperate the characters
    data = data';               % In order to reshape rows first
    data = reshape(data,1,[]);  % Reshape to one line
    data = cat(2,data{:});      % Concatenate the characters
end

function sample = readSample(fid,sample_num,sample_type)
    sample = cast(fread(fid,sample_num,sample_type),sample_type);
    sample = sample';
end
