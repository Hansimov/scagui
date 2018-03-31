function rk=SM4KeyExt(key, CryptFlag) %//秘钥扩展算法,flag为1代表解密 

CK = [
    hex2dec('00070e15'), hex2dec('1c232a31'), hex2dec('383f464d'), hex2dec('545b6269'),
    hex2dec('70777e85'), hex2dec('8c939aa1'), hex2dec('a8afb6bd'), hex2dec('c4cbd2d9'),
    hex2dec('e0e7eef5'), hex2dec('fc030a11'), hex2dec('181f262d'), hex2dec('343b4249'),
    hex2dec('50575e65'), hex2dec('6c737a81'), hex2dec('888f969d'), hex2dec('a4abb2b9'),
    hex2dec('c0c7ced5'), hex2dec('dce3eaf1'), hex2dec('f8ff060d'), hex2dec('141b2229'),
    hex2dec('30373e45'), hex2dec('4c535a61'), hex2dec('686f767d'), hex2dec('848b9299'),
    hex2dec('a0a7aeb5'), hex2dec('bcc3cad1'), hex2dec('d8dfe6ed'), hex2dec('f4fb0209'),
    hex2dec('10171e25'), hex2dec('2c333a41'), hex2dec('484f565d'), hex2dec('646b7279')
    ];

RK = [hex2dec('A3B1BAC6'), hex2dec('56AA3350'), hex2dec('677D9197'), hex2dec('B27022DC')];

k0=bitxor(key(0+1),RK(0+1));  
k1=bitxor(key(1+1),RK(1+1));  
k2=bitxor(key(2+1),RK(2+1));  
k3=bitxor(key(3+1),RK(3+1));

for r=0+1:4:28+1
%rk(i) = k(4+i) = k(i) xor T[k(i+1) xor k(i+2) xor k(i+3) xor CK(i)]
%合成置换T的过程包括非线性变换（ByteSub函数，从SBox中查找）和线性变换（L2函数，移位和异或运算）
    tmp=bitxor(bitxor(bitxor(k1,k2),k3),CK(r+0));
    tmp=SboxTrans(tmp);
    k0=bitxor(k0,L2(tmp));
    rk(r+0)=k0;
    
    tmp=bitxor(bitxor(bitxor(k2,k3),k0),CK(r+1));
    tmp=SboxTrans(tmp);
    k1=bitxor(k1,L2(tmp));
    rk(r+1)=k1;
    
    tmp=bitxor(bitxor(bitxor(k3,k0),k1),CK(r+2));
    tmp=SboxTrans(tmp);
    k2=bitxor(k2,L2(tmp));
    rk(r+2)=k2;
    
    tmp=bitxor(bitxor(bitxor(k0,k1),k2),CK(r+3));
    tmp=SboxTrans(tmp);
    k3=bitxor(k3,L2(tmp));
    rk(r+3)=k3;
end
if(CryptFlag==1)  
    for r=0+1:15+1
        tmp=rk(r);
        rk(r) = rk(33-r);
        rk(33-r)=tmp;
        %swap(rk[r],rk[31-r])
    end
end