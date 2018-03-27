function aesAttack(obj,~,~)
    chooseInterValuePosition(obj);
end

function createSettingWindow(obj)
end
function chooseInterValuePosition(obj)
%%
    import javax.swing.*
    pfig = PureFigure;
    fig = pfig.m;
    fig.Name = 'AES 攻击设置';
    fig.Visible = 'off';
    fig.Position = [1 1 800 500];
    movegui(fig,'center');
    fig.Resize = 'off';
    fig.Visible = 'on';


    % To be improved
    text_num = uicontrol(fig,'Style','text',...
        'String','请设置攻击的曲线条数：');
    text_num.Position = [70 400 200 50];
    text_num.HorizontalAlignment = 'left';
    
    jspinner_num = JSpinner(SpinnerNumberModel(200,1,1000,1));
    [~,mspinner_num] = javacomponent(jspinner_num);
    mspinner_num.Position = [270 430 100 20];
    
    jspinner_bgn = JSpinner(SpinnerNumberModel(1,1,1000,1));
    [~,mspinner_bgn] = javacomponent(jspinner_bgn);
    mspinner_bgn.Position = [270 370 80 20];
    jspinner_end = JSpinner(SpinnerNumberModel(200,1,1000,1));
    [~,mspinner_end] = javacomponent(jspinner_end);
    mspinner_end.Position = [420 370 80 20];

    text_to = uicontrol(fig,'Style','text',...
        'String','------');
    text_to.Position = [364 370 40 20];
    
    text_bits = uicontrol(fig,'Style','text',...
        'String','请选择 AES 算法类型：');
    text_bits.Position = [70 280 200 40];
    text_bits.HorizontalAlignment = 'left';
    popup_bits = uicontrol(fig,'Style','popupmenu',...
        'String',{'128-bit','192-bit','256-bit'});
    popup_bits.Position = [270 284 150 40];

    text_inter = uicontrol(fig,'Style','text',...
        'String','请选择中间值位置：');
    text_inter.HorizontalAlignment = 'left';
    text_inter.Position = [70 180 200 40];

    popup_round = uicontrol(fig,'Style','popupmenu', ...
        'String',{'第1轮','第2轮','第3轮','第4轮','第5轮', ...
        '第6轮','第7轮','第8轮','第9轮','第10轮'});
    popup_round.Position = [270 184 150 40];

    popup_algo = uicontrol(fig,'Style','popupmenu', ...
        'String',{'SubBytes','ShiftRows','MixColumns','AddRoundKey'});
    popup_algo.Position = [460 184 150 40];

    button_ok = uicontrol('Style', 'pushbutton', ...
        'String', '确定','Callback',{@chooseAttackedPoints,obj});
    button_ok.Position = [600 40 60 30];
    button_cancel = uicontrol('Style','pushbutton',...
        'String', '取消');
    button_cancel.Position = [700 40 60 30];
    %%
end

function chooseAttackedPoints(~,~,obj)
    %%
    import javax.swing.*
    pfig = PureFigure;
    fig = pfig.m;
    fig.Name = '选择攻击区域';
    fig.Visible = 'off';
    fig.Position = [1 1 1000 800];
    movegui(fig,'center');
    fig.Resize = 'off';
    fig.Visible = 'on';


    text_attacked = uicontrol(fig,'Style','text', ...
        'String','请选择攻击区域：');
    text_attacked.Position = [40 700 200 40];
    text_attacked.HorizontalAlignment = 'left';

    ax = axes(fig);
    ax.Units = 'pixels';
    ax.Position = [210 280 650 400];

    jspinner_trace = JSpinner(SpinnerNumberModel(1,1,100,1));
    [~,mspinner_trace] = javacomponent(jspinner_trace);
    mspinner_trace.Position = [800 700 80 20];

    jslider_a = JSlider;
    jslider_a.setMinimum(1); jslider_a.setMaximum(10000+1);
    jslider_a.setExtent(1);  jslider_a.setValue(1);
    jslider_b = JSlider;
    [~,mslider_a] = javacomponent(jslider_a);
    jslider_b.setMinimum(1); jslider_b.setMaximum(10000+1);
    jslider_b.setExtent(1);  jslider_b.setValue(1);
    [~,mslider_b] = javacomponent(jslider_b);

    mslider_a.Position = [210 160 650 25];
    mslider_b.Position = [210 200 650 25];

    jspinner_a = JSpinner(SpinnerNumberModel(1,1,100,1));
    [~,mspinner_a] = javacomponent(jspinner_a);
    mspinner_a.Position = [60 164 80 20];
    jspinner_b = JSpinner(SpinnerNumberModel(1,1,100,1));
    [~,mspinner_b] = javacomponent(jspinner_b);
    mspinner_b.Position = [60 204 80 20];

    text_step = uicontrol(fig,'Style','text',...
        'String','请设置相邻两点距离：');
    text_step.Position = [40 80 200 40];
    text_step.HorizontalAlignment = 'left';

    jspinner_step = JSpinner(SpinnerNumberModel(10,1,100,1));
    [~,mspinner_step] = javacomponent(jspinner_step);
    mspinner_step.Position = [260 100 100 20];

    button_ok = uicontrol('Style', 'pushbutton', ...
        'String', '确定','Callback',@(e,t)test_attack(obj));
    button_ok.Position = [600 40 60 30];
    button_cancel = uicontrol('Style','pushbutton',...
        'String', '取消');
    button_cancel.Position = [700 40 60 30];
        %%
end
    function chooseAttackedTraces()
        
    end

