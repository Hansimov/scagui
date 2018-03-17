function binvec2hex(obj)
% binvec  % [1x8] double array : [1 0 0 0 1 1 1 1]
% vvv
% hex     % [1x2]   char array : '8f'
    if ~isempty(obj.hex)
        return ;
    end
    
    binvec = obj.binvec;
    num = numel(binvec)/4;
    hex = '';
    for i = 1:num
        if binvec(4*i-3) == 0
            if binvec(4*i-2) == 0
                if binvec(4*i-1) == 0
                    if (binvec(4*i) == 0)  hex(i) = '0';
                    else                   hex(i) = '1';
                    end
                else
                    if (binvec(4*i) == 0)  hex(i) = '2';
                    else                   hex(i) = '3';
                    end
                end
            else
                if binvec(4*i-1) == 0
                    if (binvec(4*i) == 0)  hex(i) = '4';
                    else                   hex(i) = '5';
                    end
                else
                    if (binvec(4*i) == 0)  hex(i) = '6';
                    else                   hex(i) = '7';
                    end
                end
            end
        else
            if binvec(4*i-2) == 0
                if binvec(4*i-1) == 0
                    if (binvec(4*i) == 0)  hex(i) = '8';
                    else                   hex(i) = '9';
                    end
                else
                    if (binvec(4*i) == 0)  hex(i) = 'A';
                    else                   hex(i) = 'B';
                    end
                end
            else
                if binvec(4*i-1) == 0
                    if (binvec(4*i) == 0)  hex(i) = 'C';
                    else                   hex(i) = 'D';
                    end
                else
                    if (binvec(4*i) == 0)  hex(i) = 'E';
                    else                   hex(i) = 'F';
                    end
                end
            end
        end
    end
    
    obj.hex = hex;
end

