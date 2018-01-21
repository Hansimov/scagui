function str_ascii = hex2ascii(str_hex)
    str_ascii = [];
    for i = 1:numel(str_hex)/2
        byte_hex = str_hex(2*i-1:2*i);
        byte_ascii = char(hex2dec(byte_hex));
        % The title of 'viewsource trace' is big-endian 
        str_ascii = [byte_ascii str_ascii];
    end
end