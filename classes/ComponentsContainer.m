classdef ComponentsContainer < handle
% This class is to wrap the global ui components.
properties
    fig
    hbox_of_fig
    vbox_of_infos
    vbox_of_plots
    
    tabgroup_of_variables
    tabgroup_of_plots
    
    vbox_of_files 
    tab_of_fileinfo
    table_of_files
    table_of_traceinfo
    menu_of_importFile
    
end
    
methods
    function obj = ComponentsContainer()
        obj.createFig;
        obj.createBoxes;
        obj.createTabgroups;
        obj.createTabs;
        obj.createTables;
        obj.createMenus;
        obj.setFigProperties;
    end
end

methods    
    function createFig(obj)
        obj.fig= figure('Name','SCA Master', 'NumberTitle','off', 'Position',[200 200 1280 720]);
        obj.fig.MenuBar = 'None';
%         obj.top.Renderer = 'painters';
    end
    
    function createBoxes(obj)
        obj.hbox_of_fig = uix.HBoxFlex('Parent',obj.fig);
        obj.vbox_of_infos = uix.VBoxFlex('Parent',obj.hbox_of_fig);
        obj.vbox_of_plots = uix.VBoxFlex('Parent',obj.hbox_of_fig);
    end
    
    function createTabgroups(obj)
        obj.tabgroup_of_variables = uitabgroup('Parent',obj.vbox_of_infos);
        obj.tabgroup_of_plots = uitabgroup(obj.vbox_of_plots);
    end
    
    function createTabs(obj)
        obj.tab_of_fileinfo = uitab(obj.tabgroup_of_variables,'Title','文件');
    end
    
    function createTables(obj)
        obj.vbox_of_files = uix.VBoxFlex('Parent',obj.tab_of_fileinfo);
        obj.table_of_files = Xuitable('Parent',obj.vbox_of_files);
        obj.table_of_files.m.ColumnName = {'选中','文件','类型'};
        obj.table_of_files.m.ColumnEditable = [true false false];
        obj.table_of_files.m.ColumnWidth = {35 100 60};
        obj.table_of_files.m.CellEditCallback = @obj.table_of_files.updateTable;
        
        obj.table_of_traceinfo = Xuitable('Parent',obj.vbox_of_infos);
        obj.table_of_traceinfo.m.ColumnName = {'属性','值'};
        obj.table_of_traceinfo.m.ColumnWidth = {160 100};
        obj.table_of_files.m.CellSelectionCallback = {@tableOperation,obj.table_of_traceinfo.m};
    end

    
    function createMenus(obj)
        % menu_file = uimenu(fig_top,'Label','文件');
        % menu_data = uimenu(fig_top,'Label', '数据');
        % menu_analysis = uimenu(fig_top, 'Label', '分析');
        
        % menu_file_new = uimenu(menu_file, 'Label', '新建');
        obj.menu_of_importFile = uimenu(obj.fig, 'Label', '导入','Callback',{@importFile,obj.table_of_files.m});
        
        % menu_data_downsample = uimenu(menu_data, 'Label', '重采样');
        % menu_data_downsample.Callback = @dataDownSample;
        % menu_data_filter = uimenu(menu_data, 'Label', '滤波');
        % % menu_data_filter_lowpass = uimenu(menu_data_filter, 'Label', '低通');
        % menu_data_align = uimenu(menu_data, 'Label','对齐');
        
        % menu_analysis_aes = uimenu(menu_analysis, 'Label','AES');
    end
        
        
    function setFigProperties(obj)
        set(obj.hbox_of_fig, 'Widths', [-1 -2], 'Spacing', 5 );
        set(obj.vbox_of_infos, 'Heights', [-1 -2], 'Spacing', 5 );
        % This improves the redering performance remarkably!
        set(gcf, 'GraphicsSmoothing', 'off');
        set(gca, 'SortMethod','childorder');
        set(gcf, 'Renderer', 'painters'); % While 3D plots, 'opengl' is much faster than 'painters'
    end
end

end
