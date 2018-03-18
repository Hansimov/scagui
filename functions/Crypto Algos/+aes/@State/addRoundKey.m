function objnew = addRoundKey(obj,roundkey,varargin)
    objnew = returnNewobj(obj,varargin);
    
    normcell = cell(4,4);
    
    for i = 1:16
        normcell{i} = xor(obj.norm{i}, roundkey.norm{i});
    end
    
    objnew.norm = normcell;
end

