function [  ] = fTest(  )
%TEST
    % plainText(hex): 0123456789abcdef
    % key(hex): 3b3898371520f75e
    % cipherText(hex): AA39B9777EFC3C14
    
    %define Block
    plainText = [0 0 0 0 0 0 0 1 0 0 1 0 0 0 1 1 0 1 0 0 0 1 0 1 0 1 1 0 0 1 1 1 1 0 0 0 1 0 0 1 1 0 1 0 1 0 1 1 1 1 0 0 1 1 0 1 1 1 1 0 1 1 1 1];
    mBlock8_8 = reshape(plainText, 8,[])'
    %define Key
    %Hex value: 3b3898371520f75e
    key = [0 0 1 1 1 0 1 1 0 0 1 1 1 0 0 0 1 0 0 1 1 0 0 0 0 0 1 1 0 1 1 1 0 0 0 1 0 1 0 1 0 0 1 0 0 0 0 0 1 1 1 1 0 1 1 1 0 1 0 1 1 1 1 0];
    mKey8_8 = reshape(key, 8,[])'
  
    cipherText = fDES(plainText, key);
    mBlockEncrypted8_8 = reshape(cipherText, 8,[])'
end

