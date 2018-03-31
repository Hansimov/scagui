function result=LeftRot(n, b)

result = bin2dec(circshift(dec2bin(n,32)',-n)');
%return ((n << b) | ((n & 0xffffffff) >> (32 - b))) & 0xffffffff