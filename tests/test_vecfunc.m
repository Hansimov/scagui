
s1 = 'a';
S1 = strRepeat(s);
s2 = 'aa';
S2 = strRepeat(s2)



function str_out = strRepeat(str)
    num = numel(str);
%     str_size = size(str_in);
    if num == 1
        str_out = [str str];
        return;
    elseif iscell(str)
        str_out = {};
        
        for row = 1:size(str,1)
           for col = 1:size(str,2)
               str_out{row,col} = strRepeat(str);
           end
        end
    end
end