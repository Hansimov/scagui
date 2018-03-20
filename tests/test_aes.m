
plaintext = '00112233445566778899aabbccddeeff';
cipherkey = '000102030405060708090a0b0c0d0e0f';
% ciphertext = '69c4e0d86a7b0430d8cdb78070b4c55a';
% 
% tic
% for i = 1:10
% state = aes.State(plaintext);
% key = aes.Key(cipherkey);
% roundkey = key.rounds;
% roundnum = key.roundnum;
% 
% state = state.addRoundKey(roundkey{1});
% 
% for i = 1:roundnum-1
%     state = state.subBytes;
%     state = state.shiftRows;
%     state = state.mixColumns;
%     state = state.addRoundKey(roundkey{i+1});
% end
% 
% state = state.subBytes;
% state = state.shiftRows;
% state = state.addRoundKey(roundkey{roundnum+1});
% end
% 
% toc


tic
state = aes.State(plaintext);
key = aes.Key(cipherkey);
roundkey = key.rounds;
roundnum = key.roundnum;

state.addRoundKey(roundkey{1},'old');

for i = 1:roundnum-1
    state.subBytes('old');
    state.shiftRows('old');
    state.mixColumns('old');
    state.addRoundKey(roundkey{i+1},'old');
end

state = state.subBytes();
state.shiftRows('old');
state.addRoundKey(roundkey{roundnum+1},'old')

toc
