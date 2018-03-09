function downSample(~,~,obj)
    down_rate = createDownsampleWindow(obj.sample_num);
    if down_rate == -1
        return ;
    end
    obj_new = obj.copy;
    obj_new.status.isDownsampled = true;
    sample_downed = cell(obj.trace_num,1);
    progress_bar = waitbar(0,'正在对曲线进行降采样 ...','Name','降采样', ...
        'CreateCancelBtn','setappdata(gcbf,''canceling'',1)');
    setappdata(progress_bar,'canceling',0);
    for i = 1:obj.trace_num
        if getappdata(progress_bar,'canceling')
            break ;
        end
        waitbar(i/obj.trace_num,progress_bar,sprintf('正在处理曲线： %05d / %05d',i,obj.trace_num));
        sample_vec = cell2mat(obj.trs_sample(i,1));
        sample_downed{i} = traceDownsample(sample_vec,down_rate);
    end
    canceled = getappdata(progress_bar,'canceling');
    % Use delete(), instead of close() !
    delete(progress_bar);

    if ~canceled
        obj_new.trs_sample = sample_downed;
        obj_new.trs_info.ns{2} = size(obj_new.trs_sample{1},2); % Number of Samples
        obj_new.trs_info.xs{2} = down_rate * obj.trs_info.xs{2}; % X-axis Scale
        global vars;
        vars.files{end+1} = obj_new;
    end
end