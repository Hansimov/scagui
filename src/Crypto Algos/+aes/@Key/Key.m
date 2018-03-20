classdef Key < handle
properties (SetObservable, AbortSet)
    bitnum       % 128, 192, 256
    initkeycol   %   4,   6,   8
    roundnum     %  10,  12,  14
    columnnum    %  44,  52,  60
    
    hexrow  % 128-bit: [1x32] char array
            %          '2b7e151628aed2a6abf7158809cf4f3c'
            %           2b 7e 15 16  28 ae d2 a6  ab f7 15 88  09 cf 4f 3c
            % 192-bit: [1x48] char array
            % 256-bit: [1x64] char array
            
%     hexmat  % 128-bit: [4x4] or [1x16] or ... chars(1x2) cell (Column-wise): 
%             %          {'2b', '28', 'ab','09'; '7e','ae', ...}
%             % 192-bit: [4x6] or [1x24] or ... chars(1x2) cell (Column-wise)
%             % 256-bit: [4x8] or [1x32] or ... chars(1x2) cell (Column-wise)
%     
    norm    % 128-bit: [4x4] Byte cell
            % 192-bit: [4x6] Byte cell
            % 256-bit: [4x8] Byte cell
            
    columns  % (Expanded)
             % 128-bit: [1x44] KeyColumn cell
             % 192-bit: [1x52] KeyColumn cell
             % 256-bit: [1x60] KeyColumn cell    
    rounds   % (Expanded)
             % 128-bit: [1x11] State cell
             % 192-bit: [1x13] State cell
             % 256-bit: [1x15] State cell

end

methods
    function obj = Key(varargin)
        if isempty(varargin)
            return ;
        else
            keyin = varargin{1};
        end
        
        changedProp = obj.initialize(keyin);
        obj.typeConversion(changedProp);
        obj.addListeners;
        
    end

end
methods
    changedProp = initialize(obj,keyin);
    typeConversion(obj,varargin);
    addListeners(obj);
end

methods
    function hexrow2norm(obj)
        normcell = cell(4,obj.bitnum/32);
        for i = 1:numel(normcell)
           byte = obj.hexrow(1,2*i-1:2*i);
           normcell{i} = aes.Byte(byte);
        end
        obj.norm = normcell;
    end
end

methods
   [columns, rounds] = keyExpansion(obj);
end


end
















