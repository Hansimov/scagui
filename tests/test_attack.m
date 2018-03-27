% KEY XOR OPc
% 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16
% AE 05 5C 88 C9 40 E6 3B 22 F1 42 32 D0 AE 89 DA
% 
% KEY
% 54 7B 15 39 C5 27 68 0B 04 56 C0 58 76 2B 43 10
% 
% 有四组曲线，分别是原始曲线，低通滤波后的曲线，及分别对两轮S盒输出对齐后的曲线
% 
% 每组曲线都有data和trace两个矩阵，data是每条曲线对应的16字节明文，trace是对应的功耗曲线

% intervalfile = fopen('hal9000.m','w');
% fclose(intervalfile)
% delete('hal9000.m')

% function test_attack(obj)
%     import javax.swing.*

    % mf = matfile('F:\Sources\MATLAB\work\scagui\traces\usim_trs\usim_lowpass_align.mat');
    % trs_sample = mf.trs_sample;
    % trs_data = mf.trs_data;

%     pfig = PureFigure;
%     fig = pfig.m;
%     ax = axes(fig);
%     trace_num = size(trs_data,1);
% 
%     sm = SpinnerNumberModel(1,1,trace_num,1); % init, min, max, step
%     js = JSpinner(sm);
%     [jsp,msp] = javacomponent(js);
%     set(jsp,'StateChangedCallback',{@updatePlot,ax,trs_sample,trs_data})
%     jsp.setValue(2);
%     jsp.setValue(1);

    trace_num = 99;
%     aesAttack(obj.trs_sample,obj.trs_data,trace_num);
    aesAttack(trs_sample,trs_data,trace_num);

function aesAttack(trs_sample,trs_data,trace_num)
    pfig_table = PureFigure;
    fig_table  = pfig_table.m;
    fig_table.MenuBar = 'figure';
    fig_table.ToolBar = 'none';
    
%     pfig_plot = PureFigure;
%     fig_plot = pfig_plot.m;
%     fig_plot.MenuBar = 'figure';
%     fig_plot.ToolBar = 'none';
%     ax_plot = cell(1,16);
%     for i = 1:16
%         ax_plot{i} = subplot(4,4,i);
%         for j = 1:256
% %             line_plot{i,j} = line(ax_plot{i});            
%             xdata{i,j} = [];
%             ydata{i,j} = [];
%         end
%     end
    
    disp( '[*] Preprocessing original traces ...');
%     attacked_range = 1:10:60000;
%     attacked_points = getAttackedPoints(trs_sample,attacked_range);
    load('inter_and_corr.mat'); % 'attacked_points','intervalue_matrix','correlation_mean'
%     intervalue_matrix = zeros(trace_num,256,16);
    box = uix.VBoxFlex('Parent',fig_table);
    guess_table = uitable(box,'Units','normalized','RowStriping','off',...
        'FontName','Consolas','ColumnWidth',num2cell(80*ones(1,16)));
%     correlation_mean = cell(trace_num,1);
    for trace_index = 1:trace_num
        disp(['[*] Processing trace : ',num2str(trace_index,'%05d')]);
        disp( '    [*] Computing inter value ...');
%         intervalue_matrix(trace_index,:,:) = getInterValueOfTrace(trs_data, trace_index);
        disp( '    [*] Computing correlation ...');
%         correlation_matrix = getCorrelationOfTrace(attacked_points,intervalue_matrix,trace_index);
%         correlation_mean{trace_index} = getMeanOfCorrelation(correlation_matrix); % 256x16
        disp( '    [*] Sorting correlation ...');
        [max_corr, max_index] = max(correlation_mean{trace_index},[],1); % 1x16, 1x16
        [sort_corr, sort_index] = sort(correlation_mean{trace_index},1,'descend'); % 256x16, 256x16
        disp( '    [*] Creating guessed key table ...');
        key_corr_cell = joinKeyAndCorr(sort_corr, sort_index);
        guess_table.Data = key_corr_cell;
%         plot(16subplot)
        fig_table.Name = num2str(trace_index,'%05d');
        drawnow
%         plotRank(ax_plot, xdata,ydata, sort_corr, sort_index,trace_index);
        % heatmap
    end

%     save('inter_and_corr.mat','attacked_points','intervalue_matrix','correlation_mean','-v7.3')

end


% function plotRank(ax_plot, xdata,ydata, sort_corr, sort_index,trace_index)
% % sort_corr: 256x16
% % sort_index: 256x16
%     for i = 1:16
%         for j = 1:256
%             xdata{i,j}(end+1) = trace_index;
%             ydata{i,j}(end+1) = sort_corr(j,i);
% %             line_plot{i,j}.XData = xdata{i,j};
% %             line_plot{i,j}.YData = ydata{i,j};
%             plot(ax_plot{i},xdata{i,j},ydata{i,j});
%             hold on
%         end
%     end
% end

% function updatePlot(src,~,ax,trs_sample,trs_data)
%     num = src.getValue;
%     plot(ax,trs_sample{num});
%     data_text = text(ax);
%     data_text.Units = 'normalized';
%     data_text.Position = [0.5 1.05];
%     data_text.HorizontalAlignment = 'center';
%     data_text.FontName = 'YaHei Consolas Hybrid'; % This font is not existent!
%     data_text.FontSize = 12;
%     data_text.String = trs_data{num};
% end


function byteout = getInterValueOfOneByte(bytein, key_guess)
    % We get 1 aes.Byte
    byteout = xor(bytein,key_guess);
    byteout = byteout.sub;
end

function intervalue_matrix_2d = getInterValueOfTrace(trs_data,trace_index)
    intervalue_matrix_2d = zeros(256,16);
    plaintext = trs_data{trace_index};
    state = aes.State(plaintext);
    for key_index = 1:256 % To Improve: use hex directly!
        key_guess = dec2hex(key_index-1,2);
        key_guess = aes.Byte(key_guess); 
        for byte_index = 1:16
            byte = state.norm{byte_index};
            byte = getInterValueOfOneByte(byte,key_guess);
            intervalue_matrix_2d(key_index,byte_index) = byte.hw;
        end
    end
end

function attacked_points = getAttackedPoints(trs_trace,attacked_range)
    trs_trace_mat = double(cell2mat(trs_trace));
    attacked_points = trs_trace_mat(:,attacked_range);
end

function correlation_matrix = getCorrelationOfTrace(attacked_points,intervalue_matrix,trace_index)
    point_num = size(attacked_points,2);
    correlation_matrix = zeros(256,point_num,16);
    for byte_index = 1:16
        intervalue_matrix_current = intervalue_matrix(1:trace_index,:,byte_index);  % dx256
        attacked_points_current = attacked_points(1:trace_index,:);     % dxM
        correlation_matrix(:,:,byte_index) = corr(intervalue_matrix_current, attacked_points_current); % 256xM
    end
end
function correlation_mean = getMeanOfCorrelation(correlation_matrix)
    % We will get [256x16] (double) matrix
    correlation_mean = zeros(256,1,16);
    for byte_index = 1:16
        correlation_matrix_current = correlation_matrix(:,:,byte_index); % 256xM
        % Here I choose the top 50 points in correlation
        % Sort each row by descend
%         [sort_corr,~] = sort(correlation_matrix_current, 2, 'descend');
%         correlation_matrix_valuable = sort_corr(:,1:50); % 256x50
        % The 'sort' takes a lot of time, so I write the 'getMaxN' by myself.
        correlation_matrix_valuable = getMaxK(correlation_matrix_current,10,'row'); % 256x20

        % Mean each row
        correlation_mean(:,:,byte_index) = mean(correlation_matrix_valuable,2); % 256x1
    end
    correlation_mean = squeeze(correlation_mean); % 256x16
end


% function key_max = getMaxKey(max_index)
%     key_max = cell(1,16);
%     for byte_index = 1:16
%         key_max{byte_index} = dec2hex(max_index(byte_index)-1,2);
%     end
% end
% 
% function key_sort = getSortKey(sort_index)
%     key_sort = cell(256,16);
%     for key_index = 1:256
%         for byte_index = 1:16
%             key_sort{byte_index} = dec2hex(sort_index(key_index,byte_index)-1,2);
%         end
%     end
% end

function key_corr_cell = joinKeyAndCorr(sort_corr, sort_index)
    key_corr_cell = cell(256,16);
%     sort_corr=round(sort_corr,4);
    for i = 1:256*16
        key_hex = xdec2hex(sort_index(i)-1);
        try
            green_scale = xdec2hex(floor((sort_corr(i))*255));
            red_scale   = xdec2hex(floor((1-sort_corr(i))*255));
        catch
            green_scale = '00';
            red_scale = '00';
        end
        color_str = ['"#', red_scale, green_scale, '00">'];
%         color_str = ['"#',green_scale, '0000">'];
%         color_str = ['"#',green_scale,'00', green_scale,'">'];
        html_head = ['<html><font color=', color_str];
        key_corr_cell{i} = [html_head, key_hex , ' (' , num2str(sort_corr(i)), ')'];
    end
end

function matout = getMaxK(matin,K,orient)
    row = size(matin,1);
    col = size(matin,2);
    if strcmp(orient,'row')
        matout = zeros(row,K);
        for i = 1:K
           [max_value, max_index] = max(matin,[],2);
           for r = 1:row
               matin(r,max_index(r)) = -inf;
           end
           matout(:,i) = max_value;
        end
    elseif strcmp(orient,'col')
        matout = zeros(K,col);
        for i = 1:K
            [max_value, max_index] = max(matin,[],1);
            for c = 1:col
                matin(max_index(c),c) = -inf;
            end
            matout(i,:) = max_value;
        end
    else
        error('Invalid argument!');
    end
end

% attack process
% for i = 1:trace_num
%     get intervalue of current trace
%     convert intervalue to Hamming Weight
%     calculate the correlation of all existing traces
%     get the best result of current number of trace
% end


% end







