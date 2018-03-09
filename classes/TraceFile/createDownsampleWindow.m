function down_rate = createDownsampleWindow(sample_num)
    purefig = PureFigure;
    fig = purefig.m;
    fig.Visible = 'off';
    fig.Resize = 'off';
    fig.Position = [1 1 400 200];
    fig.Name = '降采样';
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

