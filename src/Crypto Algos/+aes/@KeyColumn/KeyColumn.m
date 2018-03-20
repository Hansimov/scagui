classdef KeyColumn < handle
properties
    val    % [4x1] char(1x2) cell
    col    % [4x1] Byte cell
           % {aes.Byte('2b'); ... }
end

methods
    function obj = KeyColumn(varargin)
        if isempty(varargin)
            return ;
        else
            obj.val = varargin{1};
            colcell = cell(4,1);
            for i = 1:4
                colcell{i} = aes.Byte(obj.val{i});
            end
            obj.col = colcell;
        end
            
%         obj.addListeners;
    end
    
%     function addListeners(obj)
%         addlisteners(obj,'col','PostSet',@obj.cell2col);
%     end
end
methods
    function objnew = rotateColumn(obj)
        objnew = aes.KeyColumn();
        objnew.col = cell(4,1);
        objnew.col(4) = obj.col(1);
        objnew.col(1:3) = obj.col(2:4);
    end
    function objnew = subBytes(obj)
        objnew = aes.KeyColumn();
        const = aes.Constant;
        sbox_tran = (const.sbox)';
        colcell = cell(4,1);
        for i = 1:4
%             byte_sub = sbox_tran{obj.col{i}.dec+1};
            byte_sub = sbox_tran{hex2dec(obj.col{i}.hex)+1};
            colcell{i} = aes.Byte(byte_sub);
        end
        objnew.col = colcell;
    end
    function objnew = xor(a,b)
        if isa(b,'char')
            tmpcol = cell(4,1);
            tmpcol{1} = b;
            for i = 2:4
                tmpcol{i} = '00';
            end
            b = aes.KeyColumn(tmpcol);
        end
        
        objnew = aes.KeyColumn();
        colcell = cell(4,1);
        for i = 1:4
            colcell{i} = xor(a.col{i}, b.col{i});
        end
        
        objnew.col = colcell;
    end
end

end

