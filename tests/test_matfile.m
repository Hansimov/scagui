% tic;
% % m1 = matfile('F:\Sources\scagui\traces\usim_trs\usim.mat'); % PC in company
% m1 = matfile('F:\Sources\MATLAB\work\scagui\traces\usim_trs\usim.mat');
% x1 = m1.trs_sample(1,:);
% toc;
% % Elapsed time is 8.686759 seconds.

tic;
m11 = matfile('F:\Sources\MATLAB\work\scagui\traces\usim_trs\usim-int8.mat');
x11 = m11.trs_sample(1,1);
% y11 = x11{:};
figure;
plot(x11{:})
xlim([0 inf])
toc;
% Elapsed time is 0.295925 seconds !!!


% tic;
% m11 = matfile('F:\Sources\MATLAB\work\scagui\traces\usim_trs\usim_noc.mat');
% x11 = m11.trs_sample(1,:);
% toc;
% Elapsed time is 24.914545 seconds.
% '-nocompression' is 8 times larger than compressed !


% tic;
% m2 = matfile('F:\Sources\scagui\traces\usim_trs\usim_73.mat');
% x2 = m2.trs_sample(1,:);
% toc;


% tic;
% m3 = matfile('F:\Sources\scagui\traces\usim_trs\celcom_int8.mat');
% % x3 = m3.trs_sample(1,:);
% class(m3.trs_sample)
% toc;
% 
% tic;
% m4 = matfile('F:\Sources\scagui\traces\usim_trs\celcom_v7_int8.mat');
% x4 = m3.trs_sample(1,:);
% % class(m4.trs_sample)
% toc;

% tic;
% m5 = matfile('F:\Sources\MATLAB\work\scagui\traces\usim_trs\celcom.mat');
% x5 = m5.trs_sample(1,:);
% toc;
% 
% tic;
% m55 = matfile('F:\Sources\MATLAB\work\scagui\traces\usim_trs\celcom_st.mat');
% x55 = m55.trs_sample(1,:);
% y55 = x55{:};
% toc;