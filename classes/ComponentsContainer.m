classdef ComponentsContainer < handle
% This class is to wrap the global ui components.
properties
    fig
    box
    tabgroup
    tab
    table
    menu
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
        obj.fig.Visible = 'on';
    end
end

methods    
    function createFig(obj)
        obj.fig = figure('Name','SCA Master');
        obj.fig.Visible = 'off';
        obj.fig.NumberTitle = 'off';
        obj.fig.Position = [200 200 1280 720];
        obj.fig.MenuBar = 'None';
        movegui(obj.fig,'center');
%         obj.top.Renderer = 'painters';
    end
    
    function createBoxes(obj)
        obj.box.fig = uix.HBoxFlex('Parent',obj.fig);
        obj.box.infos = uix.VBoxFlex('Parent',obj.box.fig);
        obj.box.plots = uix.VBoxFlex('Parent',obj.box.fig);
    end
    
    function createTabgroups(obj)
        obj.tabgroup.variables = uitabgroup('Parent',obj.box.infos);
        obj.tabgroup.plots = uitabgroup(obj.box.plots);
    end
    
    function createTabs(obj)
        obj.tab.fileinfo = uitab(obj.tabgroup.variables,'Title','文件');
    end
    
    function createTables(obj)
        obj.box.files = uix.VBoxFlex('Parent',obj.tab.fileinfo);
        obj.table.fileinfo = Xuitable('Parent',obj.box.files);
        obj.table.fileinfo.m.ColumnName = {'选中','文件','格式'};
        obj.table.fileinfo.m.ColumnEditable = [true false false];
        obj.table.fileinfo.m.ColumnWidth = {35 100 60};
%         obj.table.fileinfo.m.CellEditCallback = @obj.table.files.updateTable;
        
        obj.table.traceinfo = Xuitable('Parent',obj.box.infos);
        obj.table.traceinfo.m.ColumnName = {'属性','值'};
        obj.table.traceinfo.m.ColumnWidth = {160 100};
        obj.table.fileinfo.m.CellSelectionCallback = @tableOperation;
    end

    function createMenus(obj)
        % menu_file = uimenu(fig_top,'Label','文件');
        % menu_data = uimenu(fig_top,'Label', '数据');
        % menu_analysis = uimenu(fig_top, 'Label', '分析');
        % menu_file_new = uimenu(menu_file, 'Label', '新建');
        obj.menu.file.import = uimenu(obj.fig, 'Label', '导入','Callback', @importFile);
        
        % menu_data_downsample = uimenu(menu_data, 'Label', '重采样');
        % menu_data_downsample.Callback = @dataDownSample;
        % menu_data_filter = uimenu(menu_data, 'Label', '滤波');
        % % menu_data_filter_lowpass = uimenu(menu_data_filter, 'Label', '低通');
        % menu_data_align = uimenu(menu_data, 'Label','对齐');
        
        % menu_analysis_aes = uimenu(menu_analysis, 'Label','AES');
    end
        
    function setFigProperties(obj)
        set(obj.box.fig, 'Widths', [-1 -2], 'Spacing', 5 );
        set(obj.box.infos, 'Heights', [-1 -2], 'Spacing', 5 );
        % This improves the redering performance remarkably!
        set(gcf, 'GraphicsSmoothing', 'off');
        set(gca, 'SortMethod','childorder');
        set(gcf, 'Renderer', 'painters'); % While 3D plots, 'opengl' is much faster than 'painters'
    end
end

end


