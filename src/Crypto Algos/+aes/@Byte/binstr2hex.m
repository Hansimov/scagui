function binstr2hex(obj)
% binstr  % [1x8]   char array : '10001111'
% vvv
% hex     % [1x2]   char array : '8f'

%     if ~isempty(obj.hex)
%         return ;
%     end
%  I comment this because this does not allow change of hex
%    when other properties is set.
    
    binstr = obj.binstr;
    num = numel(binstr)/4;
    hex = '';
    for i = 1:num
        if binstr(4*i-3) == '0'
            if binstr(4*i-2) == '0'
                if binstr(4*i-1) == '0'
                    if (binstr(4*i) == '0')  hex(i) = '0';
                    else                     hex(i) = '1';
                    end
                else
                    if (binstr(4*i) == '0')  hex(i) = '2';
                    else                     hex(i) = '3';
                    end
                end
            else
                if binstr(4*i-1) == '0'
                    if (binstr(4*i) == '0')  hex(i) = '4';
                    else                     hex(i) = '5';
                    end
                else
                    if (binstr(4*i) == '0')  hex(i) = '6';
                    else                     hex(i) = '7';
                    end
                end
            end
        else
            if binstr(4*i-2) == '0'
                if binstr(4*i-1) == '0'
                    if (binstr(4*i) == '0')  hex(i) = '8';
                    else                     hex(i) = '9';
                    end
                else
                    if (binstr(4*i) == '0')  hex(i) = 'A';
                    else                     hex(i) = 'B';
                    end
                end
            else
                if binstr(4*i-1) == '0'
                    if (binstr(4*i) == '0')  hex(i) = 'C';
                    else                     hex(i) = 'D';
                    end
                else
                    if (binstr(4*i) == '0')  hex(i) = 'E';
                    else                     hex(i) = 'F';
                    end
                end
            end
        end
    end
    
    obj.hex = hex;

end

