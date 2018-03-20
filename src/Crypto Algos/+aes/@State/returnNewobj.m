function objnew = returnNewobj(obj,varargin)
    % Do not use 'isempty' in nested fucntion to check varargin
    % Because isempty(varargin) always return false even it is a 0x0 cell.
    % Use isempty(varargin{:}) instead!
    if isempty(varargin{:}) % return new obj by default
        objnew = aes.State(obj);
    else
        if strcmp(varargin{1},'new')
            objnew = aes.State(obj);
        elseif strcmp(varargin{1},'old')
            objnew = obj;
        else
            disp('Invalid options!');
        end
    end

end

