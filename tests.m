f = figure;
x = -pi:0.01:pi;
y = sin(x);
plot(x,y)
% set(gcf, 'GraphicsSmoothing','off') 
set(gcf, 'Renderer', 'painters') 
