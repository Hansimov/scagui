classdef Byte < handle
% This class is used in class 'State'
properties
    hex     % [1x2]   char array : '8f'
    binstr  % [1x8]   char array : '10001111'
    binvec  % [1x8] double array : [1 0 0 0 1 1 1 1]
%     dec     % [1x1] double       : 143
    % Since the type conversion is so frequent in the operations
    %   I may use mex to speed up if time permits.
    
end

methods
    function obj = Byte(bytein)
        obj.initialize(bytein);
        obj.toOtherTypes;
    end
    
    function initialize(obj, bytein)
        size_of_byte = size(bytein,2);
        if isa(bytein,'char')
            if size_of_byte == 2
                obj.hex = upper(bytein);
            elseif size_of_byte == 8
                obj.binstr = bytein;
            else
                disp('Invalid size of characters');
            end
        elseif isa(bytein, 'double')
            if size_of_byte == 8
                obj.binvec = bytein;
            else
                disp('Invalid size of number');
            end
        elseif isa(bytein,'logical')
            if size_of_byte == 8
                obj.binvec = double(bytein);
            else
                disp('Invalid size of number');
            end
        else
            disp('Invalid type of inputs');
        end
    end
    
    function toOtherTypes(obj)
        if ~isempty(obj.hex)
            obj.hex2binstr();
            obj.hex2binvec();
        elseif ~isempty(obj.binstr)
            obj.binstr2hex();
            obj.binstr2binvec();
        elseif ~isempty(obj.binvec)
            obj.binvec2hex();
            obj.binvec2binstr();
        end
    end
end
methods
    hex2binstr(obj);
    hex2binvec(obj);
    binstr2hex(obj);
    binstr2binvec(obj);
    binvec2binstr(obj);
    binvec2hex(obj);
end
methods
    function c = and(a,b)
        vec = and(a.binvec,b.binvec);
        c = aes.Byte(vec);
    end
    function c = or(a,b)
        vec = or(a.binvec,b.binvec);
        c = aes.Byte(vec);
    end
    function c = not(a)
        vec = not(a.binvec);
        c = aes.Byte(vec);
    end
    function c = xor(a, b)
        vec = (a.binvec ~= b.binvec);
        c = aes.Byte(vec);
    end

%    function c = nand(a,b)
%    end
%    function c = nor(a,b)
%    end
%    function c = xnor(a,b)
%    end

end
    
end
















