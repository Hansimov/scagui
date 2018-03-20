function obj_new = lowPass(obj,~,~)
% I will parse the varargin later
%   to choose mode 'gui' or 'cli'.
    xscale = obj.trs_info.xs{2};
    fscale = 1/xscale * (1e-6);
    freq_pass = chooseFreqPass(obj);
    if freq_pass == -1
        return ;
    end
    
    obj_new = obj.copy;
    obj_new.name = [obj.name '_lp'];
    obj_new.status.isLowpassed = true;
    
    lowpass_filter = designLowpassFilter(freq_pass,fscale);
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
        sample_vec = double(sample_vec);
        sample_lowpassed{i} = filter(lowpass_filter,sample_vec);
    end
    canceled = getappdata(progress_bar,'canceling');
    % Use delete(), instead of close() !
    delete(progress_bar);

    if ~canceled
        obj_new.trs_sample = sample_lowpassed;
        global vars;
        vars.files{end+1} = obj_new;
    end

end

function freq_current = chooseFreqPass(obj)
    import javax.swing.*
    
    purefig = PureFigure;
    fig = purefig.m;
    fig.Visible = 'off';
%     fig.Resize = 'off';
    fig.ToolBar = 'figure';
    fig.Position = [1 1 1280 720];
    fig.Name = '低通参数设置';
    fig.CloseRequestFcn = @closeFigure;


    xscale = obj.trs_info.xs{2};
    fscale = 1/xscale * (1e-6);
    
    len = obj.sample_num;
    lenhalf = floor((len+1)/2);

    tx = xscale * (1:len);
    fx = fscale * (1:lenhalf)/len;
    
    ax_time = subplot(2,1,1);
    ax_freq = subplot(2,1,2);
%     ax_time = axes(fig);
%     ax_freq = axes(fig);
%     ax_time.Position = [0.15 0.58 0.8 0.4];
%     ax_freq.Position = [0.15 0.08 0.8 0.4];
    
    ax_time.XLim = [tx(1) tx(end)];
    ax_freq.XLim = [fx(1) fx(end)];

    freq_pass_init = ax_freq.XLim(2)/5;
    myline = line(ax_freq);
    myline.XData = freq_pass_init * [1 1];
    myline.YData = ax_freq.YLim;
    
    warning('off','MATLAB:modes:mode:InvalidPropertySet');
    fig.WindowButtonMotionFcn = @detectPointer;
    dragging = false;

    spinner_index = JSpinner(SpinnerNumberModel(1,1,obj.trace_num,1));
    [~, mspinner_index] = javacomponent(spinner_index);
    mspinner_index.Position = [30 60 60 30];
    set(spinner_index,'StateChangedCallback',@previewFilter);
    
    spinner_freq = JSpinner(SpinnerNumberModel(freq_pass_init,0,fx(end),0.01));
    [~, mspinner_freq] = javacomponent(spinner_freq);
    mspinner_freq.Position = [30 30 60 30];
    set(spinner_freq,'StateChangedCallback',@updateLinePostion);
    function updateLinePostion(~,~)
        x = spinner_freq.getValue;
        myline.XData = x * [1 1];
    end

    btn_width = 80;
    btn_height = 30;
    fig_width = fig.Position(3);
    fig_height = fig.Position(4);
    btn_margin_left = 90;
    btn_margin_bottom = 30;
    
    btn_ok = uicontrol('Style','pushbutton','String','确定');
    btn_ok.Position = [btn_margin_left btn_margin_bottom btn_width btn_height];
    btn_ok.Callback = @buttonOk;
    btn_ok.FontSize = 10;
    
    btn_cancel = uicontrol('Style','togglebutton','String','取消');
    btn_cancel.Position = [fig_width-btn_margin_left-btn_width btn_margin_bottom btn_width btn_height];
    btn_cancel.Callback = @buttonCancel;
    btn_cancel.FontSize = 10;
    
    btn_preview = uicontrol('Style','togglebutton','String','预览');
    btn_preview.Position = [btn_margin_left btn_margin_bottom+40 btn_width btn_height];
    btn_preview.Callback = @previewFilter;
    btn_preview.FontSize = 10;

    
    movegui(fig,'center');
    fig.Visible = 'on';
    
    previewFilter();
    
    uiwait(fig);
    
    function buttonOk(~,~)
        freq_current = spinner_freq.getValue;
        uiresume(fig);
        delete(fig);
    end
    function buttonCancel(~,~)
        freq_current = -1;
        uiresume(fig);
        delete(fig);
    end
    function closeFigure(~,~)
        freq_current = -1;
        uiresume(fig);
        delete(fig);
    end

    function detectPointer(~,~)
        px = ax_freq.CurrentPoint(1,1);
        py = ax_freq.CurrentPoint(1,2);
        lx = myline.XData;
        ly = myline.YData;
        ax_pos = getpixelposition(ax_freq);
        ax_width_pix = ax_pos(3);
        ax_width_num = ax_freq.XLim(2) - ax_freq.XLim(1);
        sensitivity = 20*ax_width_num/ax_width_pix;
%         class(fig.WindowButtonDownFcn)

        % When you do nothing,
        %   the default class of WindowButtonDownFcn is '',
        %   a [0×0] empty char array, which is 'char'
        % When you are using tools like zoom or pan,
        %   the class of figure's WindowButtonDownFcn is a [3x1] 'cell'
        % if the user assigns a callback to the WindowButtonDownFcn,
        %   the class of is 'function_handle'
%         class(fig.WindowButtonDownFcn)
        if (lx(1)-sensitivity <= px) && (px <= lx(1)+sensitivity) ...
            && (ly(1) <= py) && (py <= ly(2))
            set(fig,'pointer','left');
            fig.WindowButtonDownFcn = @setDraggingTrue;
            fig.WindowButtonUpFcn =   @setDraggingFalse;
        else
            if dragging
                set(fig,'pointer','left');
                fig.WindowButtonDownFcn = @setDraggingFalse;
                fig.WindowButtonUpFcn =   @setDraggingFalse;
            else
                if isa(fig.WindowButtonDownFcn,'cell')
                else
                    set(fig,'pointer','arrow');
                end
                fig.WindowButtonDownFcn = @setDraggingFalse;
                fig.WindowButtonUpFcn =   @setDraggingFalse;
            end
        end
        
        updateLinePos();
        
        function updateLinePos()
            if dragging                
%                 if px <= ax_freq.XLim(1)+0.01 
%                     % Why I do not use fx instead of XLim?
%                     px = ax_freq.XLim(1)+0.01;
%                 end
%                 if px >= ax_freq.XLim(2)-0.01
%                     px = ax_freq.XLim(2)-0.01;
%                 end
                
                if px <= fx(1)
                    % Why I do not use fx instead of XLim?
                    px = fx(1);
                end
                if px >= fx(end)-0.1
                    px = fx(end)-0.1;
                end
                    
                % px = round(px,2);
                myline.XData = px * [1 1];
                myline.YData = ax_freq.YLim;
                spinner_freq.setValue(px);
            else
                myline.YData = ax_freq.YLim; % To keep myline looking 'infinite'
            end
        end
        
        function setDraggingTrue(~,~)
            dragging = true;
%             updateLinePos();
        end
        function setDraggingFalse(~,~)
            dragging = false;
        end
    end

    function previewFilter(varargin)
        set(fig,'Renderer','painters');
        set(fig,'GraphicsSmoothing','off');
%         preview_bar = waitbar(0.99,'正在滤波，请稍等……');
        trace_index = spinner_index.getValue;
        time_original = obj.trs_sample{trace_index};
        
        freq_current = spinner_freq.getValue;
        try
            lowpass_filter = designLowpassFilter(freq_current,fscale);
        catch
            warndlg('截止频率不符合要求，请重新选择！','滤波器设计')
            return ;
        end
        
        time_original = double(time_original);
        time_lowpassed = filter(lowpass_filter,time_original);
        
        freq_original_complex = fft(time_original);
        freq_original = abs(freq_original_complex/len);
        freq_original = freq_original(1:lenhalf);
        freq_original(2:end-1) = 2*freq_original(2:end-1);
        
        freq_lowpassed_complex = fft(time_lowpassed);
        freq_lowpassed = abs(freq_lowpassed_complex/len);
        freq_lowpassed = freq_lowpassed(1:lenhalf);
        freq_lowpassed(2:end-1) = 2*freq_lowpassed(2:end-1);
        
        plot(ax_time,tx,time_original,'DisplayName','原始功耗曲线');
        hold(ax_time,'on');
        time_ylim_original = ax_time.YLim;
        plot(ax_time,tx,time_lowpassed,'DisplayName','低通后的功耗曲线');
        hold(ax_time,'off');
        
        legend(ax_time,'show');
        ax_time.XLabel.String = 'Second';
        ax_time.XLim = [0 inf];
        ax_time.YLim = time_ylim_original; 
% This sometimes may make the height of filtered curve too high or too low.
        
        mylineXData = myline.XData;
        delete(myline);
        plot(ax_freq,fx,freq_original,'DisplayName','原始功耗曲线频谱');
        hold(ax_freq,'on');
        plot(ax_freq,fx,freq_lowpassed,'DisplayName','低通后的功耗曲线频谱');
        hold(ax_freq,'on');
        myline = line(ax_freq,'DisplayName','截止频率');
        myline.XData = mylineXData;
        myline.YData = ax_freq.YLim;
        myline.LineWidth = 3;
        hold(ax_freq,'off');
        
        legend(ax_freq,'show');
        ax_freq.XLabel.String= 'MHz';
%         ax_freq.XLim = [0 inf]; % Use this will make draggable line behave wrongly.
        
%         delete(preview_bar);
    end
end

function lowpass_filter = designLowpassFilter(freq_pass,fscale)
%     freq_trans = 2;
    freq_trans = fscale/100;
    accepted = false;
    while (freq_trans >= fscale/500 && ~accepted)
        try
            freq_stop = double(freq_pass+freq_trans*0.8);
            accepted = true;
        catch
            freq_trans = freq_trans*0.8;
        end
    end
    ripple_pass = 1;
    attenuation_stop = 60;
    sample_rate = fscale;
    lowpass_filter = designfilt('lowpassiir', ...
        'PassbandFrequency',      freq_pass, ...
        'StopbandFrequency',      freq_stop, ...
        'PassbandRipple',         ripple_pass, ...
        'StopbandAttenuation',    attenuation_stop, ...
        'DesignMethod',           'butter', ...
        'SampleRate',             sample_rate);
end




