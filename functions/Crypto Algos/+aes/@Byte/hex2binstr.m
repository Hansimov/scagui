function hex2binstr(obj)
% hex     % [1x2]   char array : '8f'
% vvv
% binstr  % [1x8]   char array : '10001111'
    hex = obj.hex;
    hex = upper(hex);
    num = numel(hex);
    binstr = '';
    for i = 1:num
        switch hex(i)
            case '0'
                binstr(1,4*i-3:4*i) = '0000';
            case '1'
                binstr(1,4*i-3:4*i) = '0001';
            case '2'
                binstr(1,4*i-3:4*i) = '0010';
            case '3'
                binstr(1,4*i-3:4*i) = '0011';
            case '4'
                binstr(1,4*i-3:4*i) = '0100';
            case '5'
                binstr(1,4*i-3:4*i) = '0101';
            case '6'
                binstr(1,4*i-3:4*i) = '0110';
            case '7'
                binstr(1,4*i-3:4*i) = '0111';
            case '8'
                binstr(1,4*i-3:4*i) = '1000';
            case '9'
                binstr(1,4*i-3:4*i) = '1001';
            case 'A'
                binstr(1,4*i-3:4*i) = '1010';
            case 'B'
                binstr(1,4*i-3:4*i) = '1011';
            case 'C'
                binstr(1,4*i-3:4*i) = '1100';
            case 'D'
                binstr(1,4*i-3:4*i) = '1101';
            case 'E'
                binstr(1,4*i-3:4*i) = '1110';
            case 'F'
                binstr(1,4*i-3:4*i) = '1111';
            otherwise
                binstr(1,4*i-3:4*i) = '0000';
        end
    end
    
    obj.binstr = binstr;

end

