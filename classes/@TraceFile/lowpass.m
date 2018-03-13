function lowPass(obj,~,~)
    
    xscale = obj.trs_info.sx{2};
    freq_pass = createLowpassWindow();
    
    obj_new = obj.copy;
    obj_new.name = [obj.name '_lp'];
    obj_new.status.isLowpassed = true;
    
    d = designLowpassFilter();
    
    sample_lowpassed = cell(obj.trace_num,1);
    
    progress_bar = waitbar(0,'正在对曲线进行低通 ...','Name','低通', ...
        'CreateCancelBtn','setappdata(gcbf,''canceling'',1)');
    setappdata(progress_bar,'canceling',0);
    
    for i = 1:obj.trace_num
        if getappdata(progress_bar,'canceling')
            break ;
        end
        waitbar(i/obj.trace_num,progress_bar,sprintf('正在处理曲线： %05d / %05d',i,obj.trace_num));
        sample_vec = cell2mat(obj.trs_sample(i,1));
        sample_lowpassed{i} = filtfilt(d,sample_vec);
    end
    canceled = getappdata(progress_bar,'canceling');
    % Use delete(), instead of close() !
    delete(progress_bar);

    if ~canceled
        obj_new.trs_sample = sample_lowpassed;
        global vars;
        vars.files{end+1} = obj_new;
    end
 
 
    function d = designLowpassFilter()
        freq_stop = freq_pass + 2;
        ripple_pass = 1;
        attenuation_stop = 60;
        sample_rate = 1/xscale * (1e-6);

        d = designfilt('lowpassiir', ...
            'PassbandFrequency',      freq_pass, ...
            'StopbandFrequency',      freq_stop, ...
            'PassbandRipple',         ripple_pass, ...
            'StopbandAttenuation',    attenuation_stop, ...
            'DesignMethod',           'butter', ...
            'SampleRate',             sample_rate);
    end

end



function freq_pass = createLowpassWindow()
    % varargout : numel == 1 : false
    % varargout : numel == 4 : [freq_pass, freq_stop]
%%
    import javax.swing.*
    purefig = PureFigure;
    fig = purefig.m;
    fig.Visible = 'off';
%     fig.Resize = 'off';
    fig.Position = [1 1 640 480];
    fig.Name = '低通参数设置';
%     fig.CloseRequestFcn = @closeFigure;
    

    ax = axes(fig);
    ax.Units = 'pixels';
    ax.Position = [130 160 300 300];
    
    txt_pass = uicontrol('Style','text');
    txt_pass.String = {'通带截止频率：'};
    txt_pass.Position = [10 80 100 30];
    txt_pass.FontSize = 10;

    jsl1 = JSlider(JSlider.HORIZONTAL, 1, 101, 1);
    % Orientation, min, max, init
%     set(jsl,'StateChangedCallback',@sliderChanged);
    % uiinspect(js);
    [jslider1, mslider1] = javacomponent(jsl1);
    mslider1.Position = [130 80 300 30];
    
    movegui(fig,'center');
    fig.Visible = 'on';
%%
    uiwait(fig);
    
    

    
    function okButton(~,~)
        down_rate = jspinner.getValue;
        closeFigure();
    end

    function cancelButton(~,~)
        down_rate = -1;
        closeFigure();
    end
    function closeFigure(~,~)
        if exist('down_rate','var')
        else
            down_rate = -1;
        end
        uiresume(fig);
        delete(fig);
    end

%%

end



