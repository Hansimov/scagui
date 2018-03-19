function addListeners(obj)
    addlistener(obj,'hexrow','PostSet',@obj.typeConversion);
end