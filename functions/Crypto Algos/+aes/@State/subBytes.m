function objnew = subBytes(obj,varargin)
    objnew = returnNewobj(obj,varargin);
    
    normcell = cell(4,4);
    const = aes.Constant;
    % MATLAB is column-wise
    sbox_transposed = (const.sbox)';
    
    for i = 1:16
        byte_substituted = sbox_transposed{obj.norm{i}.dec+1};
        normcell{i} = aes.Byte(byte_substituted);
    end
    
    objnew.norm = normcell;
end

