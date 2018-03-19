function addListeners(obj)
   % Note:
   % Avoid (as possible as you can) recursive callback through conversion of types,
   %   although I have used 'AbortSet'.
   addlistener(obj,'hex','PostSet',@obj.typeConversion);
   addlistener(obj,'binvec','PostSet',@obj.typeConversion);
%        addlistener(obj,'binstr','PostSet',@obj.typeConversion);
%        addlistener(obj,'dec','PostSet',@obj.typeConversion);
end
