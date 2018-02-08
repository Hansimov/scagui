function table_cell_operation(table_src,table_event,table_traceinfo)
% %     global file_info file_pointer file_entity;
    global file_container file_pointer;
    % When a cell is selected, it will cause an error when do other things.
    if isempty(table_event.Indices)
        return;
    end
    
    row = table_event.Indices(1);
    col = table_event.Indices(2);
    ctmenu = uicontextmenu;
    table_src.UIContextMenu = ctmenu;

    cell_data = get(table_src, 'Data');
    name_part = cell_data{row,2};
    ext_part = cell_data{row,3};
    path_part = cell_data{row,4};
    full_name = [path_part name_part ext_part];
%     set(table_traceinfo,'Data',file_info{row,1});
    set(table_traceinfo,'Data',file_container{row,1}.info);
    table_traceinfo.ColumnFormat = {'char' 'char'};
    
    create_context();

    function create_context()
        if col == 2
            if strcmp(ext_part,'.trs')
                uimenu(ctmenu,'Label','转换成 .mat 格式','Callback',@convert_to_mat);
            end
            if strcmp(ext_part,'.mat')
                uimenu(ctmenu,'Label','查看曲线','Callback',@view_file);
            end
            uimenu(ctmenu,'Label','删除对象','Callback',@delete_file);
        elseif col == 4
            uimenu(ctmenu,'Label','复制路径（包含文件名）','Callback',@copy_fullname);
            uimenu(ctmenu,'Label','复制路径','Callback',@copy_dir);
        end
    end
    function copy_fullname(~,~)
        disp(full_name);
    end
    function copy_dir(~,~)
        disp(path_part);
    end

    function view_file(~,~)
%         global axes_plot1;
        plot_trace(cell2mat(file_container{row,1}.entity.trs_sample(1,1)), 1e-8, 0.005);
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

