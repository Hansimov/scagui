function changedProp = initialize(obj,keyin)
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