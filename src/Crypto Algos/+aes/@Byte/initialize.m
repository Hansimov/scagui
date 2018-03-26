function changedProp = initialize(obj, bytein)
    size_of_byte = size(bytein,2);
    if isa(bytein,'char')
        if size_of_byte == 2
        % It is necessary to check the validity of inputs 
        %   (limits to '0'-'f'('F'))
        %   but currently I do not have enough time to consider these side issues.
            obj.hex = upper(bytein);
            changedProp = 'hex';
%             elseif size_of_byte == 8
%                 obj.binstr = bytein;
%                 changedProp = 'binstr';
        else
            disp('Invalid size of characters!');
        end
    elseif isa(bytein, 'double')
        if size_of_byte == 8
            obj.binvec = bytein;
            changedProp = 'binvec';
%             elseif size_of_byte == 1
%                 obj.dec = bytein;
%                 changedProp = 'dec';
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

