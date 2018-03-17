classdef State < handle
properties
    hexrow  % [1x32] char array (No space, here I add spaces just to make it clear.)
            %        '44 8f f4 f8  ea e2 ce a3  93 55 3e 15  fd 00 ec a1'
    hex     % [4x4]  chars(1x2) cell (Column-wise, do not forget this!): 
            %        {'44', 'ea', '93','fd'; '8f','e2', ...}
    binstr  % [4x4]  chars(1x8) cell
            %        {'01000100','11101010', ... }
    binvec  % [4x4]  double array(1x8) cell
            %        {[1 0 1 0 0 0 0 1], [1 1 1 0 1 0 1 0], ...}
%     dec     % [4x4]  double array cell
%             %        {  68, 234, 147, 253; 143, 226, ...}
    % There is no need to initialize these formats of state at the creation,
    %   and just convert their types when we need.
    % But it seems that the initialization of formats does not take much time
    %   compared to other operations,
    %   and all of the formats above are useful in the algorithm
    % So I tend to intialize these formats at the beginning.
        
    % Look, it is necessary to abstract the each byte in the State to a new clas!
    % Since the size is always [4x4] cell, 
    %   what we need to change is just the type of each byte.
    
    % What we always get at the beginning is the 'hexrow' type,
    %   so I just write the 'hexrow' to 'hex' function 'hexrow2hex' 
    %   and 'hex' to others functions like 'hex2binstr'
    % It is better to convert the type of each byte in Byte's methods,
    %   instead of converting them at the State's methods.
    % In State's methods we just need to use a for loop (cellfun is slow)
    %   to call the convert funciton in the Byte's methods.


end

methods



end



end