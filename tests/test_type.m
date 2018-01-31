% fid = fopen('test_chars.txt');
% tmp = fread(fid,1,'uint8');
% class(tmp)

% randMatrix = rand(100,500000);
% randCell = cell(100,1);
% 
% % This puts each row of the matrix into a cell
% % We get a [10 x 1] cell and each cell is a [1 x 500000] double.
% for i = 1:size(randMatrix,1)
%     randCell{i} = randMatrix(i,:);
% end
% randCell
% 
% save('randMatrix.mat','randMatrix','-v7.3');
% save('randCell.mat','randCell','-v7.3');
% 


tic;
mfMatrix = matfile('randMatrix.mat');
tmp1 = mfMatrix.randMatrix(1,:);
class(tmp1)
size(tmp1)
toc;

tic;
mfCell = matfile('randCell.mat');
tmp = mfCell.randCell(1,1); % This get the first cell contains a row vector
tmp2 = tmp{1,:};
class(tmp2)
size(tmp2)
toc;

isequal(tmp1,tmp2)
