% tf = TraceFile('F:\Sources\scagui\traces\usim_trs\usim.mat');
% tf = TraceFile('F:/Sources/MATLAB/work/scagui/traces/usim_trs/usim.mat');
f = figure;

%% 
% size(tf.trs_sample)
y = tf.trs_sample{3};

% plot(y)

%% 
freq_samp = 2;
peri_samp = 1/freq_samp;
len = tf.sample_num;

xscale = tf.trs_info.xs{2};
x = 1:len;
% x = xscale * x;

% freq_samp = 2 / xscale;
% class(y)
y = double(y);

% y = sin(2*pi*100*peri_samp*x);
% plot(x,y)

%%
len = 2^nextpow2(len);
yfft = fft(y,len);
yfft_abs = abs(yfft/len);
yfft_abs = yfft_abs(2:len/2+2);
yfft_abs(2:end-1) = 2*yfft_abs(2:end-1);
% yfft_abs(1:end) = 2*yfft_abs(1:end);

f = freq_samp * (0:len/2)/len;
plot(f,yfft_abs);
% plot(yfft_abs(5:end));

set(gcf, 'GraphicsSmoothing', 'off');
set(gca, 'SortMethod','childorder');
set(gcf,'Renderer','painters');
xlim([0 inf]);






