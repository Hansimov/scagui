% Standard plot having 100 hidden graphic elements
N=100;
x=rand(N,1);
y=rand(N,1);
cla; hold('on'); drawnow
tic
plot(0.5,0.5,'*r');
toc
for idx = 1 : N
plot(x(idx),y(idx),'ob','Visible','off');
end
% Same plot without the hidden graphic elements - 91x faster
cla; hold('on'); drawnow
tic, plot(0.5,0.5,'*r'); toc