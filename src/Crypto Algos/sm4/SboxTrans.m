function res = SboxTrans(in)

Sbox = [
    hex2dec('d6'), hex2dec('90'), hex2dec('e9'), hex2dec('fe'), hex2dec('cc'), hex2dec('e1'), hex2dec('3d'), hex2dec('b7'), hex2dec('16'), hex2dec('b6'), hex2dec('14'), hex2dec('c2'), hex2dec('28'), hex2dec('fb'), hex2dec('2c'), hex2dec('05'),
    hex2dec('2b'), hex2dec('67'), hex2dec('9a'), hex2dec('76'), hex2dec('2a'), hex2dec('be'), hex2dec('04'), hex2dec('c3'), hex2dec('aa'), hex2dec('44'), hex2dec('13'), hex2dec('26'), hex2dec('49'), hex2dec('86'), hex2dec('06'), hex2dec('99'),
    hex2dec('9c'), hex2dec('42'), hex2dec('50'), hex2dec('f4'), hex2dec('91'), hex2dec('ef'), hex2dec('98'), hex2dec('7a'), hex2dec('33'), hex2dec('54'), hex2dec('0b'), hex2dec('43'), hex2dec('ed'), hex2dec('cf'), hex2dec('ac'), hex2dec('62'),
    hex2dec('e4'), hex2dec('b3'), hex2dec('1c'), hex2dec('a9'), hex2dec('c9'), hex2dec('08'), hex2dec('e8'), hex2dec('95'), hex2dec('80'), hex2dec('df'), hex2dec('94'), hex2dec('fa'), hex2dec('75'), hex2dec('8f'), hex2dec('3f'), hex2dec('a6'),
    hex2dec('47'), hex2dec('07'), hex2dec('a7'), hex2dec('fc'), hex2dec('f3'), hex2dec('73'), hex2dec('17'), hex2dec('ba'), hex2dec('83'), hex2dec('59'), hex2dec('3c'), hex2dec('19'), hex2dec('e6'), hex2dec('85'), hex2dec('4f'), hex2dec('a8'),
    hex2dec('68'), hex2dec('6b'), hex2dec('81'), hex2dec('b2'), hex2dec('71'), hex2dec('64'), hex2dec('da'), hex2dec('8b'), hex2dec('f8'), hex2dec('eb'), hex2dec('0f'), hex2dec('4b'), hex2dec('70'), hex2dec('56'), hex2dec('9d'), hex2dec('35'),
    hex2dec('1e'), hex2dec('24'), hex2dec('0e'), hex2dec('5e'), hex2dec('63'), hex2dec('58'), hex2dec('d1'), hex2dec('a2'), hex2dec('25'), hex2dec('22'), hex2dec('7c'), hex2dec('3b'), hex2dec('01'), hex2dec('21'), hex2dec('78'), hex2dec('87'),
    hex2dec('d4'), hex2dec('00'), hex2dec('46'), hex2dec('57'), hex2dec('9f'), hex2dec('d3'), hex2dec('27'), hex2dec('52'), hex2dec('4c'), hex2dec('36'), hex2dec('02'), hex2dec('e7'), hex2dec('a0'), hex2dec('c4'), hex2dec('c8'), hex2dec('9e'),
    hex2dec('ea'), hex2dec('bf'), hex2dec('8a'), hex2dec('d2'), hex2dec('40'), hex2dec('c7'), hex2dec('38'), hex2dec('b5'), hex2dec('a3'), hex2dec('f7'), hex2dec('f2'), hex2dec('ce'), hex2dec('f9'), hex2dec('61'), hex2dec('15'), hex2dec('a1'),
    hex2dec('e0'), hex2dec('ae'), hex2dec('5d'), hex2dec('a4'), hex2dec('9b'), hex2dec('34'), hex2dec('1a'), hex2dec('55'), hex2dec('ad'), hex2dec('93'), hex2dec('32'), hex2dec('30'), hex2dec('f5'), hex2dec('8c'), hex2dec('b1'), hex2dec('e3'),
    hex2dec('1d'), hex2dec('f6'), hex2dec('e2'), hex2dec('2e'), hex2dec('82'), hex2dec('66'), hex2dec('ca'), hex2dec('60'), hex2dec('c0'), hex2dec('29'), hex2dec('23'), hex2dec('ab'), hex2dec('0d'), hex2dec('53'), hex2dec('4e'), hex2dec('6f'),
    hex2dec('d5'), hex2dec('db'), hex2dec('37'), hex2dec('45'), hex2dec('de'), hex2dec('fd'), hex2dec('8e'), hex2dec('2f'), hex2dec('03'), hex2dec('ff'), hex2dec('6a'), hex2dec('72'), hex2dec('6d'), hex2dec('6c'), hex2dec('5b'), hex2dec('51'),
    hex2dec('8d'), hex2dec('1b'), hex2dec('af'), hex2dec('92'), hex2dec('bb'), hex2dec('dd'), hex2dec('bc'), hex2dec('7f'), hex2dec('11'), hex2dec('d9'), hex2dec('5c'), hex2dec('41'), hex2dec('1f'), hex2dec('10'), hex2dec('5a'), hex2dec('d8'),
    hex2dec('0a'), hex2dec('c1'), hex2dec('31'), hex2dec('88'), hex2dec('a5'), hex2dec('cd'), hex2dec('7b'), hex2dec('bd'), hex2dec('2d'), hex2dec('74'), hex2dec('d0'), hex2dec('12'), hex2dec('b8'), hex2dec('e5'), hex2dec('b4'), hex2dec('b0'),
    hex2dec('89'), hex2dec('69'), hex2dec('97'), hex2dec('4a'), hex2dec('0c'), hex2dec('96'), hex2dec('77'), hex2dec('7e'), hex2dec('65'), hex2dec('b9'), hex2dec('f1'), hex2dec('09'), hex2dec('c5'), hex2dec('6e'), hex2dec('c6'), hex2dec('84'),
    hex2dec('18'), hex2dec('f0'), hex2dec('7d'), hex2dec('ec'), hex2dec('3a'), hex2dec('dc'), hex2dec('4d'), hex2dec('20'), hex2dec('79'), hex2dec('ee'), hex2dec('5f'), hex2dec('3e'), hex2dec('d7'), hex2dec('cb'), hex2dec('39'), hex2dec('48')
    ];

res1 = bitshift(Sbox(bitand(bitshift(in,-24),255)+1),24);
res2 = bitshift(Sbox(bitand(bitshift(in,-16),255)+1),16);
res3 = bitshift(Sbox(bitand(bitshift(in,-8),255)+1),8);
res4 = Sbox(bitand(in,255)+1);

res = bitor(bitor(bitor(res1,res2),res3),res4);

%(Sbox[(_A)>>24&0xFF]<<24|Sbox[(_A)>>16&0xFF]<<16|Sbox[(_A)>>8&0xFF]<<8|Sbox[(_A)&0xFF])