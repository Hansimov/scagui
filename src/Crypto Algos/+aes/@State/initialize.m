function changedProp = initialize(obj,statein)
    if isa(statein,'char')
        if isequal(size(statein),[1 32])
            obj.hexrow = statein;
            changedProp = 'hexrow';
        else
            disp('Invalied size of characters!')
        end
    elseif isa(statein,'cell')
        if isequal(size(statein),[4 4])
            if isa(statein{1},'aes.Byte')
                obj.norm = statein;
                changedProp = 'norm';
            elseif isa(statein{1},'char')
                obj.hexmat = statein;
                changedProp = 'hexmat';
            end
        else
            disp('Invalid size of cells!');
        end
    elseif isa(statein,'aes.State')
        obj.norm = statein.norm;
        changedProp = 'norm';
    else
        disp('Invalid type of inputs!')
    end
end