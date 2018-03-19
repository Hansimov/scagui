% mf = matfile('F:\Sources\MATLAB\work\scagui\traces\usim_trs\usim_lowpass_align.mat');
% trs_sample = mf.trs_sample;

% plot(trs_sample{1});

% KEY XOR OPc
% AE 05 5C 88 C9 40 E6 3B 22 F1 42 32 D0 AE 89 DA
% 
% KEY
% 54 7B 15 39 C5 27 68 0B 04 56 C0 58 76 2B 43 10
% 
% ���������ߣ��ֱ���ԭʼ���ߣ���ͨ�˲�������ߣ����ֱ������S���������������
% 
% ÿ�����߶���data��trace��������data��ÿ�����߶�Ӧ��16�ֽ����ģ�trace�Ƕ�Ӧ�Ĺ�������

tic
plaintext = '00112233445566778899aabbccddeeff';
cipherkey = '000102030405060708090a0b0c0d0e0f';
% ciphertext = '69c4e0d86a7b0430d8cdb78070b4c55a';

state = aes.State(plaintext);
key = aes.Key(cipherkey);
roundkey = key.rounds;
roundnum = key.roundnum;

state = state.addRoundKey(roundkey{1});

for i = 1:roundnum-1
    state = state.subBytes;
    state = state.shiftRows;
    state = state.mixColumns;
    state = state.addRoundKey(roundkey{i+1});
end

state = state.subBytes;
state = state.shiftRows;
state = state.addRoundKey(roundkey{roundnum+1});

toc