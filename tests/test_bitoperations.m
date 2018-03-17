tic
for i = 1:1
    out1 = double(bitxor([1 1 1 1],[0 1 0 1]));
end
toc
% Elapsed time is 0.083206 seconds.

tic
for i = 1:1
    out2 = BitXor([1 1 1 1], [0 1 0 1]);
end
toc
% Elapsed time is 0.006283 seconds.

out1
out2
isequal(out1,out2)

function out = BitXor(a,b)
    out = double(a~=b);
end


% 1st execution
%   bitxor: Elapsed time is 0.031521 seconds.
%   BitXor: Elapsed time is 0.010036 seconds.
% Later:
%   bitxor: Elapsed time is 0.033055 seconds.
%   BitXor: Elapsed time is 0.007391 seconds.