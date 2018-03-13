function downSample(obj,~,~)
    down_rate = createDownsampleWindow(obj.sample_num);
    if down_rate == -1
        return ;
    end
    obj_new = obj.copy;
    obj_new.name = [obj.name '_ds'];
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

function down_rate = createDownsampleWindow(sample_num)
    purefig = PureFigure;
    fig = purefig.m;
    fig.Visible = 'off';
    fig.Resize = 'off';
    fig.Position = [1 1 400 200];
    fig.Name = '降采样参数设置';
    fig.CloseRequestFcn = @closeFigure;
    
    txt_ask = uicontrol('Style','text');
    txt_ask.String = {'请设置降采样率：'};
    txt_ask.Position = [90 100 130 30];
    txt_ask.FontSize = 10;
    
    sm = javax.swing.SpinnerNumberModel(10,1,sample_num,1); % default, min, max, step
    js = javax.swing.JSpinner(sm);
    [jspinner, mspinner] = javacomponent(js);
    mspinner.Parent = fig;
    mspinner.Position = [230 112 60 20];
    
    btn_width = 80;
    btn_height = 30;
    fig_width = fig.Position(3);
    fig_height = fig.Position(4);
    btn_margin_left = 90;
    btn_margin_bottom = 30;
    
    btn_ok = uicontrol('Style','pushbutton','String','确定');
    btn_ok.Position = [btn_margin_left btn_margin_bottom btn_width btn_height];
    btn_ok.Callback = @okButton;
    btn_ok.FontSize = 10;
    
    btn_cancel = uicontrol('Style','togglebutton','String','取消');
    btn_cancel.Position = [fig_width-btn_margin_left-btn_width btn_margin_bottom btn_width btn_height];
    btn_cancel.Callback = @cancelButton;
    btn_cancel.FontSize = 10;

    movegui(fig,'center');
    fig.Visible = 'on';
    
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
end

function output_sample = traceDownsample(input_sample, down_rate)
% Why I do not use the name of 'downsample'?
% Because it is used by signal processing toolbox.
%
% This function calculate the mean value of every k numbers of the input_data,
%   while k is the down rate.
% I think that in the perspective of statistics,
%   there must be a better method theoritically to decrease the number of samples, 
%   but use mean values is okay.
% 
% Currently this function can only process vector of size 1 x N
% It is easy to extend this to more dimensions.

input_sample_num = size(input_sample,2);
% output_sample_num = floor(input_sample_num / down_rate);

sample_type = class(input_sample(1));

% Discard the remaider points
remainder_sample_num = mod(input_sample_num, down_rate);
% I remove the several samples at the end for convenience.
%   A null assignment can have only one non-colon index.
% input_sample(:,1:remainder_sample_num) = [];
input_sample(:,end:-1:end-remainder_sample_num+1) = [];
% Check sample coding type
% sample_type = class(input_sample(1));
% output_sample = zeros(1,output_sample_num, sample_type); 

% Resape input_sample
% Note that resample() is column-wise
input_sample = reshape(input_sample,down_rate,[]);

% Calculate mean value of each column,
%   'native' to reserve sample coding type
% However, using 'native' takes a lot of time,
%   so I use sample_type to convert manually.
output_sample = mean(input_sample, 1);

eval(['output_sample = ' sample_type '(output_sample);']);

end









