fig = figure;
propListener = addlistener(fig,'Color','PostSet',@(src,evnt)disp('Color changed'));

set(fig,'Color','yellow');
set(fig,'Color','blue');