function table_cell_operation(table_src,table_event)
    row = table_event.Indices(1);
    ctmenu = uicontextmenu;
    table_src.UIContextMenu = ctmenu;
    create_context();

    function create_context()
        uimenu(ctmenu,'Label','�鿴','Callback',@view_file);
        uimenu(ctmenu,'Label','ɾ��','Callback',@delete_file);
        [~,ext_part] = get_info();
        if strcmp(ext_part,'.trs')
            uimenu(ctmenu,'Label','ת���� .mat ��ʽ','Callback',@convert_to_mat);
        end
    end

    function view_file(~,~)
    end
    function delete_file(~,~)
    end
    
    function convert_to_mat(~,~)
        [full_name,~]= get_info();
    end

    function [full_name,ext_part]= get_info()
        cell_data = get(table_src, 'Data');
        name_part = cell_data{row,1};
        ext_part = cell_data{row,2};
        path_part = cell_data{row,3};
        full_name = [path_part name_part ext_part];
    end

end

