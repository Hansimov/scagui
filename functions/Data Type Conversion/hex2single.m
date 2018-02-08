function num_single = hex2single(str_hex)
% Reference: https://stackoverflow.com/a/7599616/8328786
    dec_32 = uint32(hex2dec(str_hex));
    % You can use vpa() to increase the precision, but it is unnecessary here.
    % num_single = vpa(typecast(dec_32,'single'));
    num_single = typecast(dec_32,'single');
end

% % The function below do the same thing, but the above is far more concise. 
% % I do not delete the below, because it may be useful in the futre.
% function single_num = hex2single(hex_str)
% % hex2num() in matlab converts a hex string to double number, not single
% % References: 
% %   IEEE 754
% %   http://blog.csdn.net/k346k346/article/details/50487127
% %   "Computer Organization and Design" by Patterson and Hennessy, 4th ed, Page 151~152
% % 
% % Sign Exponent   Fraction
% %  1      8         23
% % x = (-1)^S * (1+F) * 2^(E-B)
% % Bias = 127 in single
% %
% % Assume the endian of input hex_str is big-endian
% 
%     bin_vec = hex2bin(hex_str);
%     Sign = (-1)^bin_vec(1);
%     Exponent = 0;
%     for i = 2:9
%         Exponent = Exponent + 2^(9-i) * bin_vec(i);
%     end
%     Fraction = 0;
%     for i = 10:32
%         % Fraction = vpa(Fraction + 2^-(i-9) * bin_vec(i));
%         Fraction = Fraction + 2^-(i-9) * bin_vec(i);
%     end
%     % single_num = vpa(Sign * (1 + Fraction) * 2^(Exponent - 127));
%     single_num = Sign * (1 + Fraction) * 2^(Exponent - 127);

% end

