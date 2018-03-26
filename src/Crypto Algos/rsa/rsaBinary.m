function [ result ] = rsaBinary( M, d_array, N )
%RSABINARY rsa binary
%   input: M(vpi), d_array(uint8), N(vpi)
%   output: result (vpi)

C = vpi(1);

for i = 1:length(d_array)   
    for j = 1:8
        if(bitget(d_array(i),9-j))
            C = mod(C*C, N);
            C = mod(C*M, N);
        else
            C = mod(C*C, N);
        end
    end
end

result = C;

end

