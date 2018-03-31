function [ NumOfTraces, NumOfPoints ] = TraceParser( FilePath )

%----------------------------------------------------------------------
% Reading trace file
%----------------------------------------------------------------------

fid = fopen(FilePath,'r');
if fid < 0
    disp('open file error');
    return ;
end
TempResult = fread(fid,1,'int8');
%----------------------------------------------------------------------
% Initialize some value
%----------------------------------------------------------------------
TotalNumBytes = 1;
NumOfPoints = 0;

%----------------------------------------------------------------------
% Trace header parsing
%----------------------------------------------------------------------
while TempResult ~= hex2dec('5f')
    switch TempResult
        case hex2dec('41')                                                  % Trace Number
            fread(fid,1,'uint8');
            TempResult = fread(fid,1,'uint32');
            NumOfTraces = TempResult;
            TotalNumBytes = TotalNumBytes+5;
        case hex2dec('42')                                                  % Number of Points Per Trace
            ByteCount = fread(fid,1,'uint8');
            weight = 1;
            for i = 1:ByteCount
                TempResult = fread(fid,1,'uint8');
                NumOfPoints = NumOfPoints + TempResult*weight;
                weight = weight*256;
            end
            TotalNumBytes = TotalNumBytes+5;
        case hex2dec('43')
            TempResult = fread(fid,1,'uint8');
            TempResult = fread(fid,1,'uint8');
            TotalNumBytes = TotalNumBytes+2;
        case hex2dec('44') %加密数据长度
            TempResult = fread(fid,1,'uint8');
            TempResult = fread(fid,1,'uint8');
            TempResult = fread(fid,1,'uint8');
            %                 BytesOfCipher = fread(fid,TempResult,'uint8'); %数据读出多个字节，按照先读排在数组后面的顺序
            %                 for i=1:1:length(BytesOfCipher)
            %                     T=T+BytesOfCipher(i)*(16^(i-1))*(i-1)*16;
            %                 end
            %                 BytesOfCipher = T+BytesOfCipher(1);
            TotalNumBytes = TotalNumBytes+3;
        case hex2dec('45') %每条曲线空间头，保留空间
            TempResult = fread(fid,1,'uint8');
            TotalNumBytes = TotalNumBytes+1;
            TempResult = fread(fid,1,'uint8');
            TotalNumBytes = TotalNumBytes+1;
        case hex2dec('46') %全局曲线头
            TempResult = fread(fid,1,'uint8');
            TotalNumBytes = TotalNumBytes+1;
            GlobalTitle = fread(fid,TempResult,'int8');
            TotalNumBytes = TotalNumBytes+TempResult;
        case hex2dec('47') %曲线集描述
            TempResult = fread(fid,1,'uint8');
            TotalNumBytes = TotalNumBytes+1;
            Description = fread(fid,TempResult,'int8');
            TotalNumBytes = TotalNumBytes+TempResult;
        case hex2dec('48') % X坐标表示时，偏移量
            TempResult = fread(fid,1,'uint8');
            TotalNumBytes = TotalNumBytes+1;
            Xoffset = fread(fid,1,'int32');
            TotalNumBytes = TotalNumBytes+4;
        case hex2dec('49') % X坐标标签
            TempResult = fread(fid,1,'uint8');
            TotalNumBytes = TotalNumBytes+1;
            XLable = fread(fid,TempResult,'int8');
            TotalNumBytes = TotalNumBytes+TempResult;
        case hex2dec('4A') % Y坐标标签
            TempResult = fread(fid,1,'uint8');
            TotalNumBytes = TotalNumBytes+1;
            YLable = fread(fid,TempResult,'int8');
            TotalNumBytes = TotalNumBytes+TempResult;
        case hex2dec('4B') % X坐标范围
            TempResult = fread(fid,1,'uint8');
            TotalNumBytes = TotalNumBytes+1;
            XScale = fread(fid,1,'int32');
            TotalNumBytes = TotalNumBytes+4;
        case hex2dec('4C') % Y坐标范围
            TempResult = fread(fid,1,'uint8');
            TotalNumBytes = TotalNumBytes+1;
            YScale = fread(fid,1,'int32');
            TotalNumBytes = TotalNumBytes+4;
        case hex2dec('4D') % 显示曲线
            TempResult = fread(fid,1,'uint8');
            TotalNumBytes = TotalNumBytes+1;
            DisplayTrace = fread(fid,1,'int32');
            TotalNumBytes = TotalNumBytes+4;
        case hex2dec('4E') % LogScale
            TempResult = fread(fid,1,'uint8');
            TotalNumBytes = TotalNumBytes+1;
            LogScal = fread(fid,1,'int8');
            TotalNumBytes = TotalNumBytes+1;
        case hex2dec('00')
            break;
    end
    TempResult = fread(fid,1,'uint8');
    TotalNumBytes = TotalNumBytes+1;
end
TempResult = fread(fid,1,'int8');
%     TempResult = fread(fid,1,'int8');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Trace header handle finished

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
trace_sum2 = zeros(1,NumOfPoints);
for j = 1:NumOfTraces
    plaintext = fread(fid, 32, 'uint8');
    egtrace  = fread(fid, NumOfPoints, 'int8');
    trace_sum2 = trace_sum2 + egtrace';
end
trace_sum2 = trace_sum2/NumOfTraces;
i = 1;

end

