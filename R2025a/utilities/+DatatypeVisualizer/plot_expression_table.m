function [RGB,zero,ylimit,ylimits,HistCombined] = plot_expression_table(E,fun_name,my_title)
% Datatype visualization beta.
    
%   Tom Bryan and Julia Wall, 5 April 2015
%   Copyright 2015-2023 The MathWorks, Inc.

    global PLOT_EXPRESSION_NAMES
    global MAX_EXPRESSIONS_TO_LABEL
    if isempty(MAX_EXPRESSIONS_TO_LABEL)
        MAX_EXPRESSIONS_TO_LABEL = 100;
    end
    
    % bin 1 = 2^-128
    % bin 129 = 2^0
    % bin 256 = 2^127
    % The 129th bin = 2^0 = 1
    zero = 129;
    
    if nargin<2, fun_name=''; end
    if nargin<3, my_title=''; end
    
    if ~isempty(fun_name)
        E = E(strcmp(E.FunctionName,fun_name),:);
        my_title = [my_title,' (',fun_name,')'];
    end
    
    if isempty(E)
        RGB = [];
        ylimit = [];
        ylimits = [];
        HistCombined = [];
        text(0.5, 0.5,'NONE','FontSize',20);
        axis off
        return
    end
    
    [E,...
        Index,...
        log2_Eps,...
        log2_MaxAbsSim,...
        log2_MaxAbsRange,...
        log2_HistCombined,...
        underflow,...
        overflow,...
        HistCombined] = DatatypeVisualizer.expression_table_to_vars(E);

    cla
    title(my_title,'Interpreter','none');
    if isempty(log2_MaxAbsSim) || all(isinf(log2_MaxAbsSim(:)))
        axis_lim = axis;
        h = text(mean(axis_lim(1:2)),mean(axis_lim(3:4)),'NONE');
        set(h,'HorizontalAlignment','center',...
            'VerticalAlignment','middle',...
            'FontSize',14);
        axis off
        return
    end
    
    red = [226,61,45]/255;
    orange = [241,181,28]/255;
    green = [34,172,60]/255;

    yellow1 = [255, 255, 0]/255;
    
    PaleGreen = [152,251,152]/255;
    SkyBlue = [135,206,250]/255;
    LightBlue = [173,216,230]/255;
    pink = [1 0.78 0.80]; %#ok<*NASGU>
    white = [1, 1, 1];
    black = [0, 0, 0];
    azure = [240,255,255]/255;
    LightCyan = [224,255,255]/255;
    LightGray = 240*[1,1,1]/255;
    Gray = 200*[1,1,1]/255;
    
    binary_point_color = Gray; %LightGray;
    out_of_bound_color = SkyBlue;
    max_abs_sim_color = PaleGreen;
    vertical_line_color = LightGray; %LightBlue;
 
    upperbound_marker = 'v'; %'x';
    eps_marker = '^'; %'o';

    
    
    hold on
    t = 1:length(log2_MaxAbsRange);
    
    RGB = DatatypeVisualizer.histogram_to_rgb_image(log2_HistCombined,log2_MaxAbsRange,log2_Eps,zero,overflow,underflow);
    IM = image(RGB);
    
    if PLOT_EXPRESSION_NAMES && height(E) <= MAX_EXPRESSIONS_TO_LABEL
        expression_text = E.Expression;
        for n = 1:length(expression_text)
            % Add numeric type string
            prototype = E(n,:).Prototype;
            prototype = prototype{1};
            if isfi(prototype)
                if isscaleddouble(prototype)
                    prototype = fi(prototype,'DataType','Fixed');
                end
                integer_part_str = int2str(prototype.WordLength - prototype.FractionLength - issigned(prototype));
                % expression_text{n} = ['(',qpointstr(prototype.numerictype),', IL=',integer_part_str,') ',expression_text{n}];
                expression_text{n} = ['(',qpointstr(prototype.numerictype),') ',expression_text{n}];
            else
                expression_text{n} = ['(',class(prototype),') ',expression_text{n}];
            end
        end
        h = text(t,log2_MaxAbsSim+zero+2,expression_text);
        log_zero = ~isfinite(log2_MaxAbsSim);
        t_log_zero = t(log_zero);
        h_log_zero = text(t_log_zero,repmat(zero,size(t_log_zero))+2,...
            E(log_zero,:).Expression);
        set([h;h_log_zero],'HorizontalAlignment','left',...
            'VerticalAlignment','bottom',...
            'Interpreter','none',...
            'Rotation',45,...
            'FontName','Lucida Console',...
            'FontSize',14);
    end
    
    tunder = t(underflow);
    tover  = t(overflow);
    idover = Index(overflow);
    idunder = Index(underflow);
    
    [dynamic_range, I_first, I_last] = DatatypeVisualizer.find_dynamic_range(log2_HistCombined);
    simunder = I_first(underflow) - 1;
    simover = I_last(overflow) + 1;

    % Indicate values outside of range
    [ylimit,ylimits] = get_y_limit(log2_Eps,...
                                   log2_MaxAbsSim,...
                                   log2_MaxAbsRange,...
                                   log2_HistCombined,...
                                   zero);
    set(gca,'YLim',ylimit);
    if ylimit(2)-ylimit(1)>100
        ylimit_stride = 4;
    elseif ylimit(2)-ylimit(1)<100
        ylimit_stride = 1;
    else
        ylimit_stride = 2;
    end
    ylimit_stride = 1;
    %ytick = ylimit(1):ylimit_stride:ylimit(2);
    ytick = -256:256;
    set(gca,'YTick',ytick);
    ytick = ytick-zero;
    yticklabel = cell(size(ytick));
    for n=1:length(ytick)
        yticklabel{n} = num2str(ytick(n));
    end
    set(gca,'YTickLabel',yticklabel)
    % ylimit is a tight limit to the data.
    % Pad so the graph doesn't look crowded.
    ylim([max(ylimit(1)-4,1), min(ylimit(2)+4,256)]);
    if length(t)>1
        xlim([t(1)-0.5,t(end)+0.5]);
    end
    xlimit = get(gca,'xlim');
    set(gca,'XTick',1:length(Index));
    xticklabel = cell(size(Index));
    for n=1:length(Index)
        xticklabel{n} = int2str(Index(n));
    end
    set(gca,'XTickLabel',xticklabel)
    set(gca,'XGrid','off')
    set(gca,'YGrid','off')
    set(gca,'XTick',[])
    ylabel('Magnitude (Powers of two)')

    % Binary point
    line(xlim,[zero,zero],'Color',binary_point_color);
    % Only show vertical lines if there are few enough columns to not blank
    % everything with the vertical lines
    if size(E,1) < 100  % @todo make a function of screen size - Brenda Zhuang
        for x = t(1)+0.5:t(end)
            line([x x],ylimit,...
                'Color',vertical_line_color,...
                'LineWidth',0.001);
        end
    end
    figure(gcf)
    addToolbarExplorationButtons(gcf);
    axis xy
    hold off
    orient landscape
    set(gcf,'WindowButtonDownFcn',{@DatatypeVisualizer.display_expression_callback,E,ylimit})
    drawnow
end

function [ylimit,ylimits] = get_y_limit(log2_Eps,...
                                        log2_MaxAbsSim,...
                                        log2_MaxAbsRange,...
                                        log2_HistCombined,...
                                        zero)
    finite_max_abs = log2_MaxAbsSim(isfinite(log2_MaxAbsSim));
    %    ylimits2 = ceil(log2_MaxAbsSim + zero) + 4;
    %    ylim2 = max(ylimits2);
    I_first = nan(size(log2_HistCombined,2),1);
    I_last = nan(size(log2_HistCombined,2),1);
    for n = 1:size(log2_HistCombined,2)
        first = find(~isnan(log2_HistCombined(:,n)),1,'first');
        if ~isempty(first)
            % if first > log2_MaxAbsSim(n) + zero
            %     first = log2_MaxAbsSim(n) + zero;
            % end
            I_first(n) = first;
            last = find(~isnan(log2_HistCombined(:,n)),1,'last');
            % if last < log2_MaxAbsRange(n) + zero
            %     last = log2_MaxAbsRange(n) + zero;
            % end
            I_last(n) = last;
        end
    end
    ylimits1 = floor(min(I_first-zero,min(finite_max_abs))) + zero;
    ylim1 = min(ylimits1);
    ylimits2 = ceil(max(I_last-zero,min(finite_max_abs))) + zero;
    ylim2 = max(ylimits2);
    if mod(zero,2) ~= mod(ylim1,2)
        % Make ylim1 + zero even so the ticks will be even
        ylim1 = ylim1 - 1;
    end
    ylimit = [ylim1-15 ylim2+10];
    %ylimit = [1 256]; %@todo - Brenda Zhuang
    ylimits = [ylimits1(:), ylimits2(:)];
end

% LocalWords:  Zhuang
