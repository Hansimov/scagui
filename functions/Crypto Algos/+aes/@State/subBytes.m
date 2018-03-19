function objnew = subBytes(obj,varargin)
    objnew = returnNewobj(obj,varargin);
    
    normcell = cell(4,4);
    const = aes.Constant;
    % MATLAB is column-wise
    sbox_tran = (const.sbox)';
    
    for i = 1:16
%         byte_substituted = sbox_transposed{obj.norm{i}.dec+1};
% I comment 'dec' to improve the performance program
        byte_sub = sbox_tran{hex2dec(obj.norm{i}.hex)+1};
        normcell{i} = aes.Byte(byte_sub);
    end
    
    objnew.norm = normcell;
end

