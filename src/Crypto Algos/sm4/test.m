
key=[hex2dec('01234567'),hex2dec('89abcdef'),hex2dec('fedcba98'),hex2dec('76543210')];
cipher=[hex2dec('595298c7'),hex2dec('c6fd271f'),hex2dec('0402f804'),hex2dec('c33d3f66')];
plain=[hex2dec('01234567'),hex2dec('89abcdef'),hex2dec('fedcba98'),hex2dec('76543210')];
rk=[];
output=[];

rk=SM4KeyExt(key,0);
output=SM4Crypt(plain,rk);
outputh = [dec2hex(output(1),8),dec2hex(output(2),8),dec2hex(output(3),8),dec2hex(output(4),8)];


stop =1