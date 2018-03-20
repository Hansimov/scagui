function binvec2binstr(obj)
% binvec  % [1x8] double array : [1 0 0 0 1 1 1 1]
% vvv
% binstr  % [1x8]   char array : '10001111'
%
% You can use 'binvec2hex' and then 'hex2binstr'
% But experiments indicate that the time difference is little

    if isempty(obj.hex)
        obj.binvec2hex;
    end
    obj.hex2binstr;
        
%     binvec = obj.binvec;
%     num = numel(binvec);
%     binstr = '';
%     for i = 1:num
%         if binvec(i) == 1
%             binstr(1,i) = '1';
%         else
%             binstr(1,i) = '0';
%         end
%     end
%     obj.binstr = binstr;
end

