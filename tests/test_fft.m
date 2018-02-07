% Use Fourier transforms to find the frequency components of a signal buried in noise.
%% Create a signal
%  Sampling frequency: 1 kHz 
%  Signal duration :   1 secs
Fs = 800;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 2000;             % Length of signal
t = (0:L-1)*T;        % Time vector (*1T means 1 second duration)

% Form a signal containing 
%  Frequency (Hz):   50    120
%  Amplitude     :  0.7    1.0
S = 0.7*sin(2*pi*50*t) + sin(2*pi*120*t);

% Add white noise
%  Mean     : 0
%  Variance : 4
X = S + 2*randn(size(t));

% Plot the noisy signal in the time domain. 
% It is difficult to identify the frequency components 
%   by looking at the signal X(t)
plot(1000*t(1:500),X(1:500));
title('Noisy Signal');
xlabel('t (milliseconds)');
ylabel('X(t)');

%% FFT and frequency plot
Y = fft(X);

% Compute the two-sided spectrum P2. 
% Then compute the single-sided spectrum P1 based on P2 
%   and the even-valued signal length L.
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

% Define the frequency domain f,
%   and plot the single-sided amplitude spectrum P1. 
% The amplitudes are not exactly at 0.7 and 1, as expected, 
%   because of the added noise.
% On average, longer signals produce better frequency approximations.
f = Fs*(0:(L/2))/L; % This line is important!
plot(f,P1);
title('Single-Sided Amplitude Spectrum of X(t)');
xlabel('f (Hz)');
ylabel('|P1(f)|');


%% Frequency plot of the no-noise signal
Y = fft(S);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

plot(f,P1) 
title('Single-Sided Amplitude Spectrum of S(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')