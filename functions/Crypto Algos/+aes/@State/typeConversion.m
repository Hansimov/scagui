function typeConversion(obj,varargin)
    if numel(varargin) == 1     % changedProp
        changedProp = varargin{1};
    elseif numel(varargin) == 2 % src, data
        changedProp = varargin{1}.Name;
    else
        disp('Invalid size of inputs!');
        return ;
    end

    if strcmp(changedProp, 'norm')
        obj.norm2hexrow;
        obj.norm2hexmat;
    elseif strcmp(changedProp, 'hexrow')
        obj.hexrow2norm;
        obj.norm2hexmat;
    elseif strcmp(changedProp, 'hexmat')
        obj.hexmat2norm;
        obj.norm2hexrow;
    end
end