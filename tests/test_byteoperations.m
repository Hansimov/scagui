% tic
% for i = 1:10000
%     x1= dec2bin(hex2dec('8ff'));
% end
% toc
% 
% tic
% for i = 1:10000
%     x2=hex2binstr('8ff');
% end
% toc
% 1st execution
%   Elapsed time is 0.001715 seconds.
%   Elapsed time is 0.011389 seconds.
% Later execution
%   Elapsed time is 0.430774 seconds.
%   Elapsed time is 0.048622 seconds.



% c = hex2binstr('8f');
% tic
% b=[];
% for j = 1:1000
%     for i =1:numel(a)
%         b(1,i) = str2double(c(1,i));
%     end
% end
% toc
% 
% tic
% for j = 1:1000
%     a = hex2binvec('8f');
% end
% toc

% Elapsed time is 0.118119 seconds.
% Elapsed time is 0.004845 seconds.

% tic
% for i = 1:10000
% x = [1 1];
% if isequal(x,[0 0])
%     n = '0';
% elseif isequal(x,[0 1])
%     n = '1';
% elseif isequal(x,[1 0])
%     n = '2';
% elseif isequal(x,[1 1])
%     n = '3';
% end
% end
% toc
% 
% tic
% for i = 1:10000
% x = [1 1];
% if x(1)==0
%     if x(2) ==0
%         n = '0';
%     else
%         n = '1';
%     end
% else
%     if x(2) == 0
%         n = '2';
%     else
%         n = '3';
%     end
% end
% end
% toc
% 
% Elapsed time is 0.027451 seconds.
% Elapsed time is 0.001199 seconds.

% tic
% for i = 1:10000
%     tmp = binstr2hex('10111000');
%     a = hex2binvec(tmp);
% end
% toc
% 
% tic
% for i = 1:10000
%     b = binstr2binvec('10111000');
% end
% toc
% 
% Elapsed time is 0.086942 seconds.
% Elapsed time is 0.051766 seconds.
% 
% tic
% for i = 1:10000
%     tmp = binvec2hex([1 0 1 1 1 0 0 0]);
%     a = hex2binstr(tmp);
% end
% toc
% 
% tic
% for i = 1:10000
%     b = binvec2binstr([1 0 1 1 1 0 0 0]);
% end
% toc

tic
for i = 1:10000
    x = xor([1 0 1], [1 1 0]);
    b = double(x);
end
toc

tic
for i =1:10000
    c = ([1 0 1] ~= [1 1 0]);
end
toc




function binstr = binvec2binstr(binvec)
% binvec  % [1x8] double array : [1 0 0 0 1 1 1 1]
% vvv
% binstr  % [1x8]   char array : '10001111'
%
% You can use 'binvec2hex' and then 'hex2binstr'
% But experiments indicate that the time difference is little
    num = numel(binvec);
    binstr = '';
    for i = 1:num
        if binvec(i) == 1
            binstr(1,i) = '1';
        else
            binstr(1,i) = '0';
        end
    end
end



function binvec = binstr2binvec(binstr)
% binstr  % [1x8]   char array : '10001111'
% vvv
% binvec  % [1x8] double array : [1 0 0 0 1 1 1 1]
    num = numel(binstr);
    binvec = [];
    for i = 1:num
        if binstr(i) == '1'
            binvec(1,i) = 1;
        else
            binvec(1,i) = 0;
        end
    end
end

function hex = binvec2hex(binvec)
% binvec  % [1x8] double array : [1 0 0 0 1 1 1 1]
% vvv
% hex     % [1x2]   char array : '8f'
    num = numel(binvec)/4;
    hex = '';
    for i = 1:num
        if binvec(4*i-3) == 0
            if binvec(4*i-2) == 0
                if binvec(4*i-1) == 0
                    if (binvec(4*i) == 0)  hex(i) = '0';
                    else                   hex(i) = '1';
                    end
                else
                    if (binvec(4*i) == 0)  hex(i) = '2';
                    else                   hex(i) = '3';
                    end
                end
            else
                if binvec(4*i-1) == 0
                    if (binvec(4*i) == 0)  hex(i) = '4';
                    else                   hex(i) = '5';
                    end
                else
                    if (binvec(4*i) == 0)  hex(i) = '6';
                    else                   hex(i) = '7';
                    end
                end
            end
        else
            if binvec(4*i-2) == 0
                if binvec(4*i-1) == 0
                    if (binvec(4*i) == 0)  hex(i) = '8';
                    else                   hex(i) = '9';
                    end
                else
                    if (binvec(4*i) == 0)  hex(i) = 'A';
                    else                   hex(i) = 'B';
                    end
                end
            else
                if binvec(4*i-1) == 0
                    if (binvec(4*i) == 0)  hex(i) = 'C';
                    else                   hex(i) = 'D';
                    end
                else
                    if (binvec(4*i) == 0)  hex(i) = 'E';
                    else                   hex(i) = 'F';
                    end
                end
            end
        end
    end
end

function hex = binstr2hex(binstr)
% binstr  % [1x8]   char array : '10001111'
% vvv
% hex     % [1x2]   char array : '8f'
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

end



function binvec = hex2binvec(hex)
% hex     % [1x2]   char array : '8f'
% vvv
% binstr  % [1x8]   char array : '10001111'
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
    
end


function binstr = hex2binstr(hex)
    hex = upper(hex);
    num = numel(hex);
%     binstr = zeros(1,4*num);
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
end