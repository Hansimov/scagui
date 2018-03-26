function [ result ] = rsaLadder( M, d_array, N )
%RSALADDER rsa ladder
%   input: M(vpi), d_array(uint8), N(vpi)
%   output: result (vpi)

R0 = vpi(1);
R1 = M;

for i = 1:length(d_array)   
    for j = 1:8
        if(bitget(d_array(i),9-j))
            R0 = mod(R0*R1, N);
            R1 = mod(R1^2, N);
        else
            R1 = mod(R0*R1, N);
            R0 = mod(R0^2, N);
        end
    end
end

result = R0;

end

