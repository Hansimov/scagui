
tf = TraceFile('F:/Sources/MATLAB/work/scagui/traces/usim_trs/usim.mat');
fig = figure;

z = tf.trs_sample{4};
xscale = tf.trs_info.xs{2}; % 4.0000e-09
fscale = 1/xscale * (1e-6);

len = tf.sample_num;
% lenf = 2^(nextpow2(len)-1);
lenhalf = floor((len+1)/2);

tx = xscale * (1:len);
% fx = fscale * (1:lenf/2)/lenf;
fx = fscale * (1:lenhalf)/len;

z = double(z);

Fpass = 5;
Fstop = 7;
Apass = 1;
Astop = 65;

% Do not expose too many parameters to users,
%   this will only make them confused.
d = designfilt('lowpassiir', ...
 'PassbandFrequency',      Fpass, ...
 'StopbandFrequency',      Fstop, ...
 'PassbandRipple',         Apass, ...
 'StopbandAttenuation',    Astop, ...
 'DesignMethod',           'butter', ...
 'SampleRate',             fscale);

w = filtfilt(d,z);
% w = filter(d,z);
% filter is faster than filtfilt

ax3 = subplot(2,1,1);
plot(ax3,tx,z);
ax3.XLim = [0 inf];
ax3.XLabel.String = 'Second';
ax3.YLim = [-130 130];

hold on

plot(ax3,tx,w);

legend('原始功耗曲线','低通后的曲线')


Z = fft(z);
Z1 = abs(Z/len);
Z2 = Z1(1:lenhalf);
Z2(2:end-1) = 2*Z2(2:end-1);

ax4 = subplot(2,1,2);
plot(ax4,fx,Z2);

ax4.XLim = [0 inf];
ax4.XLabel.String = 'MHz';

W = fft(w);
W1 = abs(W/len);
W2 = W1(1:lenhalf);
W2(2:end-1) = 2*W2(2:end-1);

hold on
plot(ax4,fx,W2);

legend('原始功耗曲线频谱','低通后的功耗曲线频谱')


