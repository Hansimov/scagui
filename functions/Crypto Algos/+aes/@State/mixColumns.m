function objnew = mixColumns(obj,varargin)
% Refer to this : 
%   "How to solve MixColumns":
%      https://crypto.stackexchange.com/questions/2402/how-to-solve-mixcolumns
%
% Before mixColumns:
% x = {
%   'd4','e0','b8','1e';
%   'bf','b4','41','27';
%   '5d','52','11','98';
%   '30','ae','f1','e5'
% }
% After mixColumns:
% y = {
%   '04','E0','48','28';
%   '66','CB','F8','06';
%   '81','19','D3','26';
%   'E5','9A','7A','4C';
%
    objnew = returnNewobj(obj,varargin);
    
    normcell = cell(4,4);
    const = aes.Constant;
    mbox = const.mbox;
    
    for row = 1:4
        for col = 1:4
            bytetmp = aes.Byte('00');
            for i = 1:4
                multmp = mul( obj.norm{i,col}, mbox{row,i});
                bytetmp = bytetmp.xor(multmp);
            end
            normcell{row,col} = bytetmp;
        end
    end
    
    objnew.norm = normcell;
    
end

