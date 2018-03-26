

a = rand(256,16);
ff = figure;
box = uix.VBoxFlex('Parent',ff);
tt = uitable(box,'Units','normalized','RowStriping','off','ColumnWidth',num2cell(80*ones(1,16)));
    
% 0~255 => '000000' ~ '00FF00'

strcell = cell(size(a));
for i = 1:size(a,1)
    for j = 1:size(a,2)
        green_scale = dec2hex(floor((a(i,j))*255),2);
        red_scale = dec2hex(floor((1-a(i,j))*255),2);
        color_str = ['"#', red_scale,green_scale, '00">'];
%         color_str = ['"#',green_scale, '0000">'];
%         color_str = ['"#',green_scale,'00', green_scale,'">'];
        html_head = ['<html><font color=', color_str];
        strcell{i,j} = [html_head, num2str(a(i,j))];
    end
end
% str = '<HTML><BODY bgcolor="#00FF00">'

tt.Data = strcell;