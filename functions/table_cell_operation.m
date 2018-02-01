function table_cell_operation(table_src,table_event,table_traceinfo)
% %     global file_info file_pointer file_entity;
    global file_container file_pointer;
    % When a cell is selected, it will cause an error when do other things.
    if isempty(table_event.Indices)
        return;
    end
    
    row = table_event.Indices(1);
    ctmenu = uicontextmenu;
    table_src.UIContextMenu = ctmenu;

    cell_data = get(table_src, 'Data');
    name_part = cell_data{row,2};
    ext_part = cell_data{row,3};
    path_part = cell_data{row,4};
    full_name = [path_part name_part ext_part];
%     set(table_traceinfo,'Data',file_info{row,1});
    set(table_traceinfo,'Data',file_container{row,1}.info);
    
    create_context();

    function create_context()
        uimenu(ctmenu,'Label','查看','Callback',@view_file);
        uimenu(ctmenu,'Label','删除','Callback',@delete_file);
        if strcmp(ext_part,'.trs')
            uimenu(ctmenu,'Label','转换成 .mat 格式','Callback',@convert_to_mat);
        end
    end

    function view_file(~,~)
        global axes_plot1;
        plot(axes_plot1,cell2mat(file_container{row,1}.entity.trs_sample(1,1)));
        axes_plot1.XLim = [0 inf];
    end
    function delete_file(~,~)
%         file_entity(row,:) = [];
%         file_info(row,:) = [];
        file_container(row,:) = [];
        file_pointer(row,:) = [];
        set(table_traceinfo,'Data',{});
        set(table_src, 'Data', file_pointer);
    end
    
    function convert_to_mat(~,~)
        trs_fullname = full_name;
        [mat_filename,mat_pathname] = uiputfile('*.mat', '保存为...',[path_part filesep name_part]);
        if mat_filename ~=0
            mat_fullname = [mat_pathname,mat_filename];
        else
            return;
        end
         [~,canceled] = trs2mat(trs_fullname,mat_fullname);
         if ~canceled
             file_open_choice = questdlg('文件保存成功，是否在软件中打开？', '', ...
                                        '是','否','是');
             switch file_open_choice
                 case '是'
                     [mat_path_part,mat_name_part,mat_ext_part] = fileparts(mat_fullname);
                     file_pointer(end+1,1:4) = {false,mat_name_part,mat_ext_part,mat_pathname};
                     file_container{end+1,1} = TraceFile(mat_fullname);
%                      file_info{end+1,1} = get_trs_info(full_name);
                     set(table_src,'Data',file_pointer);
                 case '否'
                 otherwise
             end
         end
    end



end

