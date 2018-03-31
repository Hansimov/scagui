function Output = SM4Crypt(Input, rk)
x0=Input(0+1);  
x1=Input(1+1);  
x2=Input(2+1);  
x3=Input(3+1); 

for r=0+1:4:28+1
    tmp=bitxor(bitxor(bitxor(x1,x2),x3),rk(r+0));
    tmp=SboxTrans(tmp);
    x0=bitxor(x0,L1(tmp));
    xx(r+0)=x0;
    
    tmp=bitxor(bitxor(bitxor(x2,x3),x0),rk(r+1));
    tmp=SboxTrans(tmp);
    x1=bitxor(x1,L1(tmp));
    xx(r+1)=x1;
    
    tmp=bitxor(bitxor(bitxor(x3,x0),x1),rk(r+2));
    tmp=SboxTrans(tmp);
    x2=bitxor(x2,L1(tmp));
    xx(r+2)=x2;
    
    tmp=bitxor(bitxor(bitxor(x0,x1),x2),rk(r+3));
    tmp=SboxTrans(tmp);
    x3=bitxor(x3,L1(tmp));
    xx(r+3)=x3; 
end


% (y0,y1,y2,y3) = (x35,x34,x33,x32)
Output(0+1)=x3;  
Output(1+1)=x2;  
Output(2+1)=x1;  
Output(3+1)=x0; 