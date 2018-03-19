function typeConversion(obj,varargin)
    if numel(varargin) == 1     % changedProp
        changedProp = varargin{1};
    elseif numel(varargin) == 2 % src, data
        changedProp = varargin{1}.Name;
    else
        disp('Invalid size of inputs!');
        return ;
    end

    if strcmp(changedProp,'hexrow')
        obj.bitnum = 4*numel(obj.hexrow);
        obj.initkeycol = obj.bitnum/32;
        obj.roundnum = obj.initkeycol + 6;
        obj.columnnum = 4*(obj.roundnum+1);
        obj.hexrow2norm;
        [obj.columns, obj.rounds] = obj.keyExpansion;
    end
end