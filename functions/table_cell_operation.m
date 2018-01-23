function table_cell_operation(table_src,table_event)
    % When a cell is selected, it will cause an error when do other things.
    if isempty(table_event.Indices)
        return;
    end
    row = table_event.Indices(1);
    ctmenu = uicontextmenu;
    table_src.UIContextMenu = ctmenu;
    
    %% Basic infomation of uitable and its cells
    cell_data = get(table_src, 'Data');
    name_part = cell_data{row,1};
    ext_part = cell_data{row,2};
    path_part = cell_data{row,3};
    full_name = [path_part name_part ext_part];

    create_context();

    function create_context()
        uimenu(ctmenu,'Label','�鿴','Callback',@view_file);
        uimenu(ctmenu,'Label','ɾ��','Callback',@delete_file);
        if strcmp(ext_part,'.trs')
            uimenu(ctmenu,'Label','ת���� .mat ��ʽ','Callback',@convert_to_mat);
        end
    end

    function view_file(~,~)
    end
    function delete_file(~,~)
    end
    
    function convert_to_mat(~,~)
        trs_fullname = full_name;
        [mat_filename,mat_pathname] = uiputfile('*.mat', '����Ϊ...',[path_part filesep name_part]);
        if mat_filename ~=0
            mat_fullname = [mat_pathname,mat_filename];
        end
         trs2mat(trs_fullname,mat_fullname);
         file_open_choice = questdlg('�ļ�����ɹ����Ƿ�������д򿪣�', '', ...
                                    '��','��','��');
         switch file_open_choice
             case '��'
                 global file_info;
                 [mat_path_part,mat_name_part,mat_ext_part] = fileparts(mat_fullname);
                 file_info(end+1,1:3) = {mat_name_part,mat_ext_part,mat_pathname};
                 set(table_src,'Data',file_info);
             case '��'
             otherwise
         end
    end



end

