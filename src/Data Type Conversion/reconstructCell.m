function cell_out = reconstructCell(cell_in)
    % We get a [14 x 1] cell, and each element is a [1 x 2] cell
    % What we want is a [14 x 2] cell
    row = size(cell_in,1);
    col = size(cell_in{1},2);
    cell_out = cell(row,col);
    for i = 1:row
        for j = 1:col
            cell_out{i,j} = cell_in{i}{j};
        end
    end
end