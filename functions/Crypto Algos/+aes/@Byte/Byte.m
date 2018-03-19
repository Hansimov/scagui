classdef Byte < handle
% This class is used in class 'State'
properties (SetObservable, AbortSet)
    hex     % [1x2]   char array : '8f'
%     binstr  % [1x8]   char array : '10001111'
    binvec  % [1x8] double array : [1 0 0 0 1 1 1 1]
%     dec     % [1x1] double       : 143
% I comment 'dec' and 'binstr' to improve the performance program
    % Since the type conversion is so frequent in the operations,
    %   I may use mex to speed up if time permits.
    
end

methods
    function obj = Byte(varargin)
        if isempty(varargin)
            obj.addListeners;
            return ;
        else
            bytein = varargin{1};
        end
        
        changedProp = obj.initialize(bytein);
        obj.typeConversion(changedProp);
%         obj.addListeners;
% I comment 'addListeners' to improve the performance program
    end


end
methods
    changedProp = initialize(obj, bytein);
    typeConversion(obj,varargin);
    addListeners(obj);
end

methods
%     hex2binstr(obj);
    hex2binvec(obj);
%     binstr2hex(obj);
%     binstr2binvec(obj);
%     binvec2binstr(obj);
    binvec2hex(obj);
%     dec2hex(obj);
%     hex2dec(obj);
end


methods
    function c = and(a,varargin)
        vec = a.binvec;
        for i = 1:numel(varargin)
            vec = and(vec,varargin{i}.binvec);
        end
        c = aes.Byte(vec);
    end
    function c = or(a,varargin)
        vec = a.binvec;
        for i = 1:numel(varargin)
            vec = or(vec,varargin{i}.binvec);
        end
        c = aes.Byte(vec);
    end
    function c = not(a)
        vec = not(a.binvec);
        c = aes.Byte(vec);
    end
    function c = xor(a,varargin)
        vec = a.binvec;
        for i = 1: numel(varargin)
            vec = (vec ~= varargin{i}.binvec);
        end
        c = aes.Byte(vec);
    end
    
    c = mul(a,num);
 

%    function c = nand(a,b)
%    end
%    function c = nor(a,b)
%    end
%    function c = xnor(a,b)
%    end

end
    
end
















