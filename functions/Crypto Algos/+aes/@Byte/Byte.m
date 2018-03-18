classdef Byte < handle
% This class is used in class 'State'
properties (SetObservable, AbortSet)
    hex     % [1x2]   char array : '8f'
    binstr  % [1x8]   char array : '10001111'
    binvec  % [1x8] double array : [1 0 0 0 1 1 1 1]
    dec     % [1x1] double       : 143
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
        obj.addListeners;
    end
    
    function changedProp = initialize(obj, bytein)
        size_of_byte = size(bytein,2);
        if isa(bytein,'char')
            if size_of_byte == 2
            % It is necessary to check the validity of inputs '0'-'f'('F')
            %   but currently I do not have enough time to consider these side issues.
                obj.hex = upper(bytein);
                changedProp = 'hex';
            elseif size_of_byte == 8
                obj.binstr = bytein;
                changedProp = 'binstr';
            else
                disp('Invalid size of characters!');
            end
        elseif isa(bytein, 'double')
            if size_of_byte == 8
                obj.binvec = bytein;
                changedProp = 'binvec';
            elseif size_of_byte == 1
                obj.dec = bytein;
                changedProp = 'dec';
            else
                disp('Invalid size of numbers!');
            end
        elseif isa(bytein,'logical')
            if size_of_byte == 8
                obj.binvec = double(bytein);
                changedProp = 'binvec';
            else
                disp('Invalid size of numbers!');
            end
        elseif isa(bytein,'aes.Byte')
            obj.hex = bytein.hex;
            changedProp = 'hex';
        else
            disp('Invalid type of inputs!');
        end
    end
    
    function typeConversion(obj,varargin)
        if numel(varargin) == 1    % changedProp
            changedProp = varargin{1};
        elseif numel(varargin) == 2 % src, data
            changedProp = varargin{1}.Name;
        else
            disp('Invalid size of inputs!');
            return ;
        end
        
        if strcmp(changedProp,'hex')
            obj.hex = upper(obj.hex);
            obj.hex2binstr();
            obj.hex2binvec();
            obj.hex2dec();
        elseif strcmp(changedProp,'binstr')
            obj.binstr2hex();
            obj.binstr2binvec();
            obj.hex2dec();
        elseif strcmp(changedProp,'binvec')
            obj.binvec2hex();
            obj.binvec2binstr();
            obj.hex2dec();
        elseif strcmp(changedProp,'dec')
            obj.dec2hex();
            obj.hex2binstr();
            obj.hex2binvec();
        end
        
    end
    
    function addListeners(obj)
       % Note:
       % Avoid (as possible as you can) recursive callback through conversion of types,
       %   although I have used 'AbortSet'.
       addlistener(obj,'hex','PostSet',@obj.typeConversion);
       addlistener(obj,'binvec','PostSet',@obj.typeConversion);
       addlistener(obj,'binstr','PostSet',@obj.typeConversion);
       addlistener(obj,'dec','PostSet',@obj.typeConversion);
    end
end
methods
    hex2binstr(obj);
    hex2binvec(obj);
    binstr2hex(obj);
    binstr2binvec(obj);
    binvec2binstr(obj);
    binvec2hex(obj);
    dec2hex(obj);
    hex2dec(obj);
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

    function c = mul(a,num)
        if num == 1
            c = aes.Byte(a);
        else
            vec_shifted = [];
            vec_shifted(1:7) = a.binvec(2:8);
            vec_shifted(8) = 0;
            
            if (a.binvec(1) == 1)  % MSB == 1
                vec = (vec_shifted ~= [0 0 0 1 1 0 1 1]);
            else                   % MSB == 0
                vec = vec_shifted;
            end
            
            if num == 2
                c = aes.Byte(vec);
            elseif num == 3
                vec = (vec ~= a.binvec);
                c = aes.Byte(vec);
            else
                disp('Multiplier is greater than 3!')
            end
        end
    end

%    function c = nand(a,b)
%    end
%    function c = nor(a,b)
%    end
%    function c = xnor(a,b)
%    end

end
    
end
















