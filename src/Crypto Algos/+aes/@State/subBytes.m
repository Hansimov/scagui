function objnew = subBytes(obj,varargin)
    objnew = returnNewobj(obj,varargin);
    
    normcell = cell(4,4);

    for i = 1:16
%         byte_substituted = sbox_transposed{obj.norm{i}.dec+1};
% I comment 'dec' to improve the performance program
        normcell{i} = obj.norm{i}.sub;
    end
    
    objnew.norm = normcell;
end

