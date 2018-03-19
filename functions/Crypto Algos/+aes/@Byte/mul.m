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