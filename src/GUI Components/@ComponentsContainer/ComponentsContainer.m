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
        obj.fig.Position = [1 1 1280 720];
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
        obj.tabgroup.plots = uitabgroup('Parent',obj.box.plots);
    end
    
    function createTabs(obj)
        obj.tab.fileinfo = uitab(obj.tabgroup.variables,'Title','变量浏览区');
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
        obj.menu.file = uimenu(obj.fig,'Label','文件');
        obj.menu.data = uimenu(obj.fig,'Label', '数据');
        obj.menu.analysis = uimenu(obj.fig, 'Label', '分析');
        obj.menu.file_new = uimenu(obj.menu.file, 'Label', '新建');
        obj.menu.file_import = uimenu(obj.menu.file, 'Label', '导入','Callback', @importFile);
        
        obj.menu.data_downsample = uimenu(obj.menu.data, 'Label', '降采样');
        obj.menu.data_lowpass = uimenu(obj.menu.data, 'Label', '低通滤波');
        obj.menu.data_align = uimenu(obj.menu.data, 'Label','对齐');
        
        obj.menu.analysis_aes = uimenu(obj.menu.analysis, 'Label','AES');
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


