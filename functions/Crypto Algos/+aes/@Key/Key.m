classdef Key < handle
properties (SetObservable, AbortSet)
    len     % 128, 192, 256
    
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
%     norm    % 128-bit: [4x4] Byte cell
%             % 192-bit: [4x6] Byte cell
%             % 256-bit: [4x8] Byte cell
%             
    round   % 128-bit: [1x11] State cell
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
        obj.keyExpansion;
        obj.addListeners;
        
    end
    
    function initialize(obj,keyin)
        if isa(keyin,'char')
            keysize = size(keyin,2);
            if keysize == 32 || keysize == 48 || keysize == 64
                obj.hexrow = keyin;
                changedProp = 'hexrow';
            else
                disp('Invalid size of characters!');
            end
%         elseif isa(keyin,'cell')
%         elseif isa(keyin,'aes.Key')
        end
    end
    
    function typeConversion(obj,varargin)
        if numel(varargin) == 1     % changedProp
            changedProp = varargin{1};
        elseif numel(varargin) == 2 % src, data
            changedProp = varargin{1}.Name;
        else
            disp('Invalid size of inputs!');
            return ;
        end
        
        if strcmp('changedProp','hexrow')
            obj.len = numel(obj.hexrow);
        end
    end
end




end
















