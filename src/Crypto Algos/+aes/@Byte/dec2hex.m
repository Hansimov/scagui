function dec2hex(obj)
% dec     % [1x1] double       : 143
% vvv
% hex     % [1x2]   char array : '8f'
    obj.hex = dec2hex(obj.dec,2);
end

