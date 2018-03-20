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
    
    for i = 1:2 %obj.trace_num
        if getappdata(progress_bar,'canceling')
            break ;
        end
        waitbar(i/obj.trace_num,progress_bar,sprintf('正在处理曲线： %05d / %05d',i,obj.trace_num));
        sample_vec = cell2mat(obj.trs_sample(i,1));
        sample_lowpassed{i} = filtfilt(lowpass_filter,sample_vec);
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
    fig.Resize = 'off';
    fig.Position = [1 1 1280 720];
    fig.Name = '低通参数设置';
    fig.CloseRequestFcn = @closeFigure;


    xscale = obj.trs_info.xs{2};
    fscale = 1/xscale * (1e-6);
    
    len = obj.sample_num;
    lenhalf = floor((len+1)/2);

    tx = xscale * (1:len);
    fx = fscale * (1:lenhalf)/len;
    
%     ax_time = subplot(2,1,1);
%     ax_freq = subplot(2,1,2);
    ax_time = axes(fig);
    ax_freq = axes(fig);
    
    ax_time.Position = [0.15 0.58 0.8 0.4];
    ax_freq.Position = [0.15 0.08 0.8 0.4];
    
    ax_time.XLim = [tx(1) tx(end)];
    ax_freq.XLim = [fx(1) fx(end)];

    freq_pass_init = 5;
    myline = line(ax_freq);
    myline.XData = freq_pass_init * [1 1];
    myline.YData = ax_freq.YLim;
    
    warning('off','MATLAB:modes:mode:InvalidPropertySet');
%     fig.WindowButtonMotionFcn = @detectPointer;
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

    
    movegui(fig,'center');
    fig.Visible = 'on';
    uiwait(fig);
    
    function buttonOk(~,~)
        freq_current = spinner_freq.getValue;
        closeFigure();
    end
    function buttonCancel(~,~)
        freq_current = -1;
        closeFigure();
    end
    function closeFigure(~,~)
        if exist('freq_pass','var')
        else
            freq_current = -1;
        end
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
        
        if (lx(1)-sensitivity <= px) && (px <= lx(1)+sensitivity) ...
                && (ly(1) <= py) && (py <= ly(2))
            % When you are using tools like zoom or pan,
            %   the class of figure's WindowButtonDownFcn is a [3x1] 'cell'
            % if the user assigns a callback to the WindowButtonDownFcn,
            %   the class of is 'function_handle'
            % The default class of WindowButtonDownFcn is '', which is 'char'
            if ~strcmp(class(fig.WindowButtonDownFcn),'cell')
                set(fig,'pointer','left');
            end
            fig.WindowButtonDownFcn = @setClickedTrue;
            fig.WindowButtonUpFcn =   @setClickedFalse;
        elseif ~dragging
            if ~strcmp(class(fig.WindowButtonDownFcn),'cell')
                set(fig,'pointer','arrow');
            end
            fig.WindowButtonDownFcn = @setClickedFalse;
            fig.WindowButtonUpFcn =   @setClickedFalse;
        end
        
        if dragging
            if px <= ax_freq.XLim(1)
                px = ax_freq.XLim(1);
            end
            if px >= ax_freq.XLim(2)
                px = ax_freq.XLim(2);
            end
%             px = round(px,2);
            myline.XData = px * [1 1];
            myline.YData = ax_freq.YLim;
            spinner_freq.setValue(px);
        else
%                 disp('Not Clicked');
        end
        
        function setClickedTrue(~,~)
            dragging = true;
        end
        function setClickedFalse(~,~)
            dragging = false;
        end
    end

    function previewFilter(~,~)
        trace_index = spinner_index.getValue;
        time_original = obj.trs_sample{trace_index};
        
        freq_current = spinner_freq.getValue;
        lowpassFilter = designLowpassFilter(freq_current,fscale);
        
        time_original = double(time_original);
        time_lowpassed = filtfilt(lowpassFilter,time_original);
        
        freq_original_complex = fft(time_original);
        freq_original = abs(freq_original_complex/len);
        freq_original = freq_original(1:lenhalf);
        freq_original(2:end-1) = 2*freq_original(2:end-1);
        
        freq_lowpassed_complex = fft(time_lowpassed);
        freq_lowpassed = abs(freq_lowpassed_complex/len);
        freq_lowpassed = freq_lowpassed(1:lenhalf);
        freq_lowpassed(2:end-1) = 2*freq_lowpassed(2:end-1);
        
        hold on
        plot(ax_time,tx,time_original,'DisplayName','原始功耗曲线');
%         hold on
%         plot(ax_time,tx,time_lowpassed,'DisplayName','低通后的功耗曲线');

        legend(ax_time,'show');
        
        ax_time.XLabel.String = 'Second';
        ax_time.XLim = [0 inf];
        
        hold off
        plot(ax_freq,fx,freq_original,'DisplayName','原始功耗曲线频谱');
        hold on
        plot(ax_freq,fx,freq_lowpassed,'DisplayName','低通后的功耗曲线频谱');
        hold off
        legend(ax_freq,'show');
        ax_freq.XLabel.String= 'MHz';
        ax_freq.XLim = [0 inf];
    end
end
        % set(gcf,'Renderer','painters');
    % set(gcf,'GraphicsSmoothing','off');

function lowpass_filter = designLowpassFilter(freq_pass,fscale)
    freq_stop = freq_pass + 2;
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




