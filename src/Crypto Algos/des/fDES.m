function [ cipherText ] = fDES ( plainText, key )
% 
% Encrypt the plain text with key using des algorithm
% 
% Input:
%      plainText, 1 * 64 binary matrix, the data to be encrypted.
%      key, 1 * 64 binary matrix, DES's key.
% Output:
%      cipherText, 1 * 64 binary matrix, result of the encryption.
% Reference: fips46-3, https://csrc.nist.gov/csrc/media/publications/fips/46/3/archive/1999-10-25/documents/fips46-3.pdf

%initial Permutation
    [ vValueLeft32, vValueRight32 ] = fInitalPermutation( plainText );
    
    for i = 1:16
        [ vValueLeft32, vValueRight32 ] = fRound( i, vValueLeft32, vValueRight32, key );
    end
    cipherText = fFinalPermutation( vValueLeft32, vValueRight32 );
end

