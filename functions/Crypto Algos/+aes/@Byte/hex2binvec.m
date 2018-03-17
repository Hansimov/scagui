function hex2binvec(obj)
% hex     % [1x2]   char array : '8f'
% vvv
% binvec  % [1x8] double array : [1 0 0 0 1 1 1 1]
    hex = obj.hex;
    hex = upper(hex);
    num = numel(hex);
    binvec = [];
    for i = 1:num
        switch hex(i)
            case '0'
                binvec(1,4*i-3:4*i) = [0 0 0 0];
            case '1'
                binvec(1,4*i-3:4*i) = [0 0 0 1];
            case '2'
                binvec(1,4*i-3:4*i) = [0 0 1 0];
            case '3'
                binvec(1,4*i-3:4*i) = [0 0 1 1];
            case '4'
                binvec(1,4*i-3:4*i) = [0 1 0 0];
            case '5'
                binvec(1,4*i-3:4*i) = [0 1 0 1];
            case '6'
                binvec(1,4*i-3:4*i) = [0 1 1 0];
            case '7'
                binvec(1,4*i-3:4*i) = [0 1 1 1];
            case '8'
                binvec(1,4*i-3:4*i) = [1 0 0 0];
            case '9'
                binvec(1,4*i-3:4*i) = [1 0 0 1];
            case 'A'
                binvec(1,4*i-3:4*i) = [1 0 1 0];
            case 'B'
                binvec(1,4*i-3:4*i) = [1 0 1 1];
            case 'C'
                binvec(1,4*i-3:4*i) = [1 1 0 0];
            case 'D'
                binvec(1,4*i-3:4*i) = [1 1 0 1];
            case 'E'
                binvec(1,4*i-3:4*i) = [1 1 1 0];
            case 'F'
                binvec(1,4*i-3:4*i) = [1 1 1 1];
            otherwise
                binvec(1,4*i-3:4*i) = [0 0 0 0];
        end
    end
    
    obj.binvec = binvec;

end