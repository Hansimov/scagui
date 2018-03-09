function viewFile(~,~,obj)
    global vars comps;
    vars.tabs{end+1} = Xuitab(comps.tabgroup.plots,'Title',num2str(numel(vars.tabs)));
    vars.tabs{end}.file = obj; % This line should be put before the below.
    vars.tabs{end}.type = 'original';
end