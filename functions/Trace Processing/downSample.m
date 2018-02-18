function output_sample = downSample(input_sample, down_rate)
% Why I do not use the name of 'downsample'?
% Because it is used by signal processing toolbox.
%
% This function calculate the mean value of every k numbers of the input_data,
%   while k is the down rate.
% I think that in the perspective of statistics,
%   there must be a better method theoritically to decrease the number of samples, 
%   but use mean values is okay.
% 
% Currently this function can only process vector of size 1 x N
% It is easy to extend this to more dimensions.

input_sample_num = size(input_sample,2);
% output_sample_num = floor(input_sample_num / down_rate);

% Discard the remaider points
remainder_sample_num = mod(input_sample_num, down_rate);
% I choose the several samples at the beginning for convenience
%   A null assignment can have only one non-colon index.
% input_sample(:,1:remainder_sample_num) = [];
input_sample(:,end:-1:end-remainder_sample_num+1) = [];

% Check sample coding type
% sample_type = class(input_sample(1));
% output_sample = zeros(1,output_sample_num, sample_type); 

% Resape input_sample
% Note that resample() is column-wise
input_sample = reshape(input_sample,down_rate,[]);

% Calculate mean value of each column, 
%   'native' to reserve sample coding type
output_sample = mean(input_sample, 1, 'native');


end

