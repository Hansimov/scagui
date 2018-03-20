function addListeners(obj)
    addlistener(obj,'norm','PostSet',@obj.typeConversion);
    addlistener(obj,'hexrow','PostSet',@obj.typeConversion);
    addlistener(obj,'hexmat','PostSet',@obj.typeConversion);
end