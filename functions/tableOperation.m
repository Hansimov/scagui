function tableOperation(table_src, table_event)

    global comps vars;
    % When a cell is selected, it will cause an error when do other things.
    if isempty(table_event.Indices)
        return;
    end
    
    row = table_event.Indices(1);
    col = table_event.Indices(2);
    ctmenu = uicontextmenu;
    table_src.UIContextMenu = ctmenu;
    
    current_fileinfo = vars.files{row}.info;
%     disp(cell_data);
%     cell_data = get(table_src, 'Data');
%     name_part = cell_data{row,2};
%     ext_part = cell_data{row,3};
%     path_part = cell_data{row,4};
%     full_name = [path_part name_part ext_part];

    set(comps.table.traceinfo.m,'Data', current_fileinfo);
    comps.table.traceinfo.m.ColumnFormat = {'char' 'char'};
    
    createContext(ctmenu);

    function createContext(ctmenu)
        vars.files{row}.createContextMenu(ctmenu);

    end

end

