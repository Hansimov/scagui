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
%             obj.hex2binstr();
        obj.hex2binvec();
%             obj.hex2dec();
%         elseif strcmp(changedProp,'binstr')
%             obj.binstr2hex();
%             obj.binstr2binvec();
%             obj.hex2dec();
    elseif strcmp(changedProp,'binvec')
        obj.binvec2hex();
%             obj.binvec2binstr();
%             obj.hex2dec();
%         elseif strcmp(changedProp,'dec')
%             obj.dec2hex();
%             obj.hex2binstr();
%             obj.hex2binvec();
    end

end
