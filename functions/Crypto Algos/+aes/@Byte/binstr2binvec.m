function binstr2binvec(obj)
% binstr  % [1x8]   char array : '10001111'
% vvv
% binvec  % [1x8] double array : [1 0 0 0 1 1 1 1]
%
% You can use 'binstr2hex' and then 'hex2binvec'
% But experiments indicate that the time difference is little

    if isempty(obj.hex)
        obj.binstr2hex;
    end
    obj.hex2binvec;
    
%     binstr = obj.binstr;
%     num = numel(binstr);
%     binvec = [];
%     for i = 1:num
%         if binstr(i) == '1'
%             binvec(1,i) = 1;
%         else
%             binvec(1,i) = 0;
%         end
%     end
%     
%     obj.binvec = binvec;
end

