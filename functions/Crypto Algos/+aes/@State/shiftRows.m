function objnew = shiftRows(obj,varargin)
    objnew = returnNewobj(obj,varargin);
    
    normcell = cell(4,4);
    % Why I use a tmp norm ?
    % To avoid update 'norm' (I add a listener to it) at each for loop.
    for row = 1:4
        head = objnew.norm(row,row:4);
        tail = objnew.norm(row,1:row-1);
        normcell(row,1:4) = [head tail];
    end
    
    objnew.norm = normcell;

end

