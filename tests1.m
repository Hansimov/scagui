warning('off', 'MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');
jFrame = get(handle(gcf),'JavaFrame');
% jFrame.setMinimized(true);
plot(1:5); 
jFrame = get(gcf,'JavaFrame');