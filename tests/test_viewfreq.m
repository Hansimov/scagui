% tf = TraceFile('F:\Sources\scagui\traces\usim_trs\usim.mat');
f = figure;

%% 
% size(tf.trs_sample)
y = tf.trs_sample{3};

% plot(y)

%% 
freq_samp = 1e3;
peri_samp = 1/freq_samp;
len = tf.sample_num;


xscale = tf.trs_info.xs{2};
x = 1:len;
% x = xscale * x;

% class(y)
y = double(y);
class(y)
% y = sin(2*pi*100*peri_samp*x);
% plot(x,y)

%%
% n = 2^nextpow2(L);
yfft = fft(y);
yfft_abs = abs(yfft/len);
yfft_abs = yfft_abs(1:len/2+1);
yfft_abs(2:end-1) = 2*yfft_abs(2:end-1);
% yfft_abs(1:end) = 2*yfft_abs(1:end);

f = freq_samp * (0:len/2)/len;
plot(f,yfft_abs);

set(gcf, 'GraphicsSmoothing', 'off');
set(gca, 'SortMethod','childorder');
set(gcf,'Renderer','painters');
xlim([0 inf]);






