function [ output_args ] = keyExpansion( input_args )
% Refer to these: 
%   "Announcing the ADVANCED ENCRYPTION STANDARD (AES)": Appendix A -- Key Expansion Examples
%      http://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.197.pdf
%   "The Design of Rijndael": 
%      Section 3.6 -- Key Schedule | 
%      List 3.3 The key expansion for Nk <= 6.
%      List 3.4 The key expansion for Nk >  6.
%      https://link.springer.com/content/pdf/10.1007%2F978-3-662-04722-4.pdf
%   "How to use RCON In Key Expansion of 128 Bit Advanced Encryption Standard"
%      https://crypto.stackexchange.com/questions/2418/how-to-use-rcon-in-key-expansion-of-128-bit-advanced-encryption-standard
%   "What are the practical differences between 256-bit, 192-bit, and 128-bit AES encryption?"
%      https://crypto.stackexchange.com/questions/20/what-are-the-practical-differences-between-256-bit-192-bit-and-128-bit-aes-enc/1527#1527
%   "How does the key schedule of Rijndael looks for keysizes other than 128 bit?"
%      https://crypto.stackexchange.com/questions/2486/how-does-the-key-schedule-of-rijndael-looks-for-keysizes-other-than-128-bit/2496#2496
%


% The key expansion works in a way that 
%   K(i) only depends directly on K(i?1) and k(i?Nk) 
%     (where Nk is the number of columns in the key, i.e. 4 for AES-128).
% In most cases it is a simple ?, 
%   but after each Nk key columns, a non-linear function 'fi' is applied.
% The functions 'fi' are nonlinear functions build from 
%   the AES S-box (applied on each byte separately), 
%   a rotation by one byte,
%   and an XOR with a Round Constant depending on i 
%     (this is the element of GF(2^8) corresponding to x^(i?1), 
%      but there also is a table in the standard).
% For AES-128
%   the key selection algorithm simply takes k0¡­k3 as the first round key,
%   k4¡­k7 as the second one, until k40¡­k43 as the last one. 
%
% AES-192 looks almost the same, 
%   but with 6 columns in parallel.
% As we need 13 round keys (=52 key columns), 
%   this will be done until k51 (i.e. 8 full rows and 4 keys in the 9th row).
%
% For AES-256 (and all variants of Rijndael with more than 192 bits of key),
%   there is an additional non-linear transformation after the 4th column:
%
% ---------- AES-256 ---------- %
% Nb = 4;                  % Nb: Block Columns = (Block Bits)/32
% Nk = 8;                  % Nk: Cipher Key Size
% Nr = 14;                 % Nr: Round Number
% K = cipher_key;          % K : Cipher Key     Nb x Nk     = 4 x 8
% W = cell(Nb,Nb*(Nr+1));  % W : Expanded Key   Nb x (Nr+1) = 4 x 15
% ----------------------------- %

% Nb: the number of columns in the state
% Nk: the number of columns of the cipher key
% Nr: the number of rounds
% Nr is a function of Nb and Nk.
% For the AES, Nb is fixed to the value 4.
%   so the bitnum of the block is 4*32 = 128 bits.
% Nr = 10 for 128-bit keys (Nk = 4), 
% Nr = 12 for 192-bit keys (Nk = 6), 
% Nr = 14 for 256-bit keys (Nk = 8)


% --------------------------------------------------------------
%   BitNum    BlockColumn(Nb)   CipherKeyColumn(Nk)   RoundNum(Nr)
% --------------------------------------------------------------
%     128         4                4                 10
%     192         4                6                 12
%     256         4                8                 14
% --------------------------------------------------------------
%
% During the key expansion,
%   the cipher key is expanded into an expanded key array, 
%   consisting of 4 rows and Nb*(Nr+1) columns. 
% This array is here denoted by W[4][Nb*(Nr+1)]. 
% The round key of the i-th round, ExpandedKey[i],
%   is given by the columns Nb*i to Nb*(i+1)-1 of W.

% The key expansion function depends on the value of Nk: 
%   there is aversion for Nk <= 6, shown in List 3.3, 
%   and a version for Nk > 6, shown in List 3.4. 
% In both versions of the key expansion, 
%   the first Nk columns of W are filled with the cipher key. 
% The following columns are defined recursively in terms of previously defined columns. 
% The recursion uses the bytes of the previous column, 
%   the bytes of the column Nk positions earlier,
%   and round constants RC[j].

% The recursion function depends on the position of the column. 
% If i is not a multiple of Nk, 
%   column i is the bitwise XOR of columns i-Nk and column i-1. 
% Otherwise, column i is the bitwise XOR of column i-Nk 
%   and a nonlinear function of column i-1. 
% For cipher key length values Nk > 6, 
%   this is also the case if i mod Nk = 4. 
% The non-linear function is realized by means of 
%   the application of Srd to the four bytes of the column, 
%   an additional cyclic rotation of the bytes within the column 
%   and the addition of a round constant (for elimination of symmetry).
% The round constants are independent of Nk,
%   and defined by a recursion rule in GF(2^8 ) :

end

