% function myui
%     f = figure;
%     myData = { 'A '  31; 'B'  41; 'C'  5; 'D' 2.6};
%     t = uitable('Parent',f,...
%                 'Position', [25 25 700 200], ...
%                 'Data',myData,...
%                 'ColumnEditable', [false true], ...
%                 'CellEditCallback',@converttonum);
%         function converttonum(hObject,callbackdata)
%              numval = eval(callbackdata.EditData);
%              r = callbackdata.Indices(1)
%              c = callbackdata.Indices(2)
%              hObject.Data{r,c} = numval; 
%         end
% end


% function test()
% f = figure('Position',[200 200 400 150]);
% dat = rand(3); 
% cnames = {'X-Data','Y-Data','Z-Data'};
% rnames = {'First','Second','Third'};
% t = uitable('Parent',f,'Data',dat,'ColumnName',cnames,... 
%             'CellSelectionCallback', @cbk, ...
%             'RowName',rnames,'Position',[20 20 360 100]);
%       function cbk(~, ~)
%           ty = get(f, 'SelectionType')
%       end
% end

