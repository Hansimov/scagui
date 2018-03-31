function res = L1(x)

t1 = bitxor(x,LeftRot(x,-2));
t2 = bitxor(t1,LeftRot(x,-10));
t3 = bitxor(t2,LeftRot(x,-18));
res = bitxor(t3,LeftRot(x,-24));
%L1(x) ((x)^Rotl(x,2)^Rotl(x,10)^Rotl(x,18)^Rotl(x,24))  