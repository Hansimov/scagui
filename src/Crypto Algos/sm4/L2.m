function res = L2(x)

t1 = bitxor(x,LeftRot(x,-13));
res = bitxor(t1,LeftRot(x,-23));

%L2(x) ((x)^Rotl(x,13)^Rotl(x,23)) 