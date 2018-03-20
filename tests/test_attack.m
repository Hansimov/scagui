% KEY XOR OPc
% AE 05 5C 88 C9 40 E6 3B 22 F1 42 32 D0 AE 89 DA
% 
% KEY
% 54 7B 15 39 C5 27 68 0B 04 56 C0 58 76 2B 43 10
% 
% 有四组曲线，分别是原始曲线，低通滤波后的曲线，及分别对两轮S盒输出对齐后的曲线
% 
% 每组曲线都有data和trace两个矩阵，data是每条曲线对应的16字节明文，trace是对应的功耗曲线


% mf = matfile('F:\Sources\MATLAB\work\scagui\traces\usim_trs\usim_lowpass_align.mat');

% trs_sample = mf.trs_sample;
% trs_data = mf.trs_data;
% 
% size(trs_data)

% plot(trs_sample{1});

intervalfile = fopen('hal9000.m','w')
fclose(intervalfile)
delete('hal9000.m')
