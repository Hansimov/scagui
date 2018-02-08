function bin_vec = hex2bin(hex_str)
hex_str = upper(hex_str);
hex_str_num = numel(hex_str);
bin_vec = zeros(1,4*hex_str_num);
for i = 1:hex_str_num
    switch hex_str(i)
        case '0'
            bin_vec(1,4*i-3:4*i) = [0 0 0 0];
        case '1'
            bin_vec(1,4*i-3:4*i) = [0 0 0 1];
        case '2'
            bin_vec(1,4*i-3:4*i) = [0 0 1 0];
        case '3'
            bin_vec(1,4*i-3:4*i) = [0 0 1 1];
        case '4'
            bin_vec(1,4*i-3:4*i) = [0 1 0 0];
        case '5'
            bin_vec(1,4*i-3:4*i) = [0 1 0 1];
        case '6'
            bin_vec(1,4*i-3:4*i) = [0 1 1 0];
        case '7'
            bin_vec(1,4*i-3:4*i) = [0 1 1 1];
        case '8'
            bin_vec(1,4*i-3:4*i) = [1 0 0 0];
        case '9'
            bin_vec(1,4*i-3:4*i) = [1 0 0 1];
        case 'A'
            bin_vec(1,4*i-3:4*i) = [1 0 1 0];
        case 'B'
            bin_vec(1,4*i-3:4*i) = [1 0 1 1];
        case 'C'
            bin_vec(1,4*i-3:4*i) = [1 1 0 0];
        case 'D'
            bin_vec(1,4*i-3:4*i) = [1 1 0 1];
        case 'E'
            bin_vec(1,4*i-3:4*i) = [1 1 1 0];
        case 'F'
            bin_vec(1,4*i-3:4*i) = [1 1 1 1];
        otherwise
            bin_vec(1,4*i-3:4*i) = [0 0 0 0];
    end
end
end
