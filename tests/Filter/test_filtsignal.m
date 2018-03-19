% t = linspace(-pi,pi,100);
% rng default  %initialize random number generator
% x = sin(t) + 0.25*rand(size(t));
% 
% windowSize = 10; 
% b = (1/windowSize)*ones(1,windowSize);
% a = 1;
% 
% y = filter(b,a,x);
% 
% plot(t,x)
% hold on
% plot(t,y)
% legend('Input Data','Filtered Data')

%%
figure;

Fpass = 200;
Fstop = 290;
Apass = 1;
Astop = 65;
Fs = 1e3;
T = 1/Fs;

% If you want the frequencies in designfilt and fft plots to be the same,
%   you need to make the two Fs be the same:
%   'SampleRate' Fs in designfilt
%   'Frequency'  Fs in x-axis sequence : f = Fs*(0:(len/2))/len;
% If the signal is also created by yourself,
%   you should also make the sample rate of x-axis sequency:
%   t = (1:len)/Fs;
%   x = sin(2*pi*50*t) + sin(2*pi*200*t) + sin(2*pi*300*t);


d = designfilt('lowpassfir', ...
  'PassbandFrequency',Fpass,'StopbandFrequency',Fstop, ...
  'PassbandRipple',Apass,'StopbandAttenuation',Astop, ...
  'DesignMethod','equiripple','SampleRate',Fs);

len = 1000;

% t = linspace(-pi,pi,len);
% rng default  %initialize random number generator
% x = sin(2*pi*T*t) + 0.25*rand(size(t));

t = (1:len)/Fs;

x = sin(2*pi*5*t) + sin(2*pi*200*t) + sin(2*pi*300*t);

y = filter(d,x);

ax1 = subplot(2,1,1);
plot(t,x)
hold on
plot(t,y)
legend(ax1, 'original','filtered')

% figure;

ax2 = subplot(2,1,2);

f = Fs*(0:(len/2))/len;

X = fft(x);
X1 = abs(X/len);
X2 = X1(1:len/2+1);
X2(2:end-1) = 2*X2(2:end-1);
plot(f,X2)

hold on
Y = fft(y);
Y1 = abs(Y/len);
Y2 = Y1(1:len/2+1);
Y2(2:end-1) = 2*Y2(2:end-1);

plot(f,Y2)

legend(ax2,'original','filtered')


