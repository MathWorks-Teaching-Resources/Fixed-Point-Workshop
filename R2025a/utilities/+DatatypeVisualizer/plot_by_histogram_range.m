function varargout = plot_by_histogram_range(E)
% Datatype visualization beta.
    
%   Tom Bryan and Julia Wall, 5 April 2015
%   Copyright 2015-2022 The MathWorks, Inc.

    global PLOT_EXPRESSION_NAMES
    global MAX_EXPRESSIONS_TO_LABEL
    if isempty(MAX_EXPRESSIONS_TO_LABEL)
        MAX_EXPRESSIONS_TO_LABEL = 100;
    end



    zero = 129;

    % red    rgb(226,61,45)
    % orange rgb(241,181,28)
    % green  rgb(34,172,60)

    red = [226,61,45]/255;
    orange = [241,181,28]/255;
    green = [34,172,60]/255;

    PaleGreen = [152, 251, 152]/255;
    SkyBlue = [135, 206, 250]/255;
    pink = [1, 0.78, 0.80]; %#ok<*NASGU>
    yellow1 = [255, 255, 0]/255;
    Gray = 200*[1,1,1]/255;
    
    upperbound_color = SkyBlue; % red;
    upperbound_marker = 'v'; % 'x';
    eps_color = SkyBlue; % yellow1 %orange;
    eps_marker = '^'; % 'o';
    max_abs_sim_color = PaleGreen;
    binary_point_color = Gray;


    [E,...
     ~,...
     log2_Eps,...
     log2_MaxAbsSim,...
     log2_MaxAbsRange,...
     log2_HistCombined,...
     underflow,...
     overflow] = DatatypeVisualizer.expression_table_to_vars(E);
    
    t = 1:length(log2_MaxAbsRange);


    [dynamic_range, I_first, I_last] = DatatypeVisualizer.find_dynamic_range(log2_HistCombined);

    [~,I] = sort(I_first-I_last,'ascend');
    I_first = I_first(I);
    I_last = I_last(I);
    E = E(I,:);
    log2_Eps         = log2_Eps(I);
    log2_MaxAbsSim   = log2_MaxAbsSim(I);  
    log2_MaxAbsRange = log2_MaxAbsRange(I);
    log2_HistCombined = log2_HistCombined(:,I);
    underflow = underflow(I);
    overflow = overflow(I);
    tunder = t(underflow);
    tover  = t(overflow);

    Index = E.Index;

    log2_Hist_Aligned = nan(size(log2_HistCombined));
    extent = zeros(size(log2_HistCombined,2),1);
    for n = 1:size(log2_HistCombined,2)
        if I_first(n) ~= 0
            extent(n) = I_last(n)-I_first(n)+1;
            log2_Hist_Aligned(1:extent(n),n) = ...
                log2_HistCombined(I_first(n):I_last(n),n);
        end
    end

    [dynamic_range, I_first_aligned, I_last_aligned] = DatatypeVisualizer.find_dynamic_range(log2_Hist_Aligned);

    if ~isempty(log2_Hist_Aligned)
        a = log2_Hist_Aligned;
        b = imagesc(a);
        set(b,'AlphaData',~isnan(a));

        line(t,log2_MaxAbsRange - I_first + zero,...
             'Color',upperbound_color,...
             'MarkerEdgeColor',upperbound_color,...
             'MarkerFaceColor',upperbound_color,...
             'Marker',upperbound_marker,...
             'LineStyle','none')
        line(t,log2_Eps - I_first + zero,...
             'Color',eps_color,...
             'MarkerEdgeColor',eps_color,...
             'MarkerFaceColor',eps_color,...
             'Marker',eps_marker,...
             'LineStyle',...
             'none');

        line(t,log2_MaxAbsSim - I_first + zero,...
             'Color',max_abs_sim_color,...
             'LineStyle','none','Marker','.');

        line(t,zero - I_first,...
             'Color',binary_point_color,...
             'Marker','.',...
             'LineStyle',...
             'none');

        simunder = I_first_aligned(underflow) - 1;
        simover = I_last_aligned(overflow) + 1;
        line(tover,simover,...
             'LineStyle','none','Marker','^',...
             'Color','r','MarkerSize',12,...
             'MarkerFaceColor','r');
        line(tunder,simunder,...
             'LineStyle','none','Marker','v',...
             'Color',orange,'MarkerSize',12,...
             'MarkerFaceColor',orange);

         if PLOT_EXPRESSION_NAMES && height(E) <= MAX_EXPRESSIONS_TO_LABEL

            h = text(t,log2_MaxAbsSim - I_first + zero + 1,E.Expression);
            log_zero = ~isfinite(log2_MaxAbsSim);
            t_log_zero = t(log_zero);
%             h_log_zero = text(t_log_zero,...
%                 log2_MaxAbsSim(log_zero) - I_first(log_zero) + zero + 1,...
%                               E(log_zero,:).Expression);
            h_log_zero = text(t_log_zero,zeros(size(t_log_zero)),...
                              E(log_zero,:).Expression);
            set([h;h_log_zero],'HorizontalAlignment','left',...
                           'VerticalAlignment','bottom',...
                           'Interpreter','none',...
                           'Rotation',45,...
                           'FontName','Lucida Console',...
                           'FontSize',14);
        end


        legends = {'Upperbound','Eps',...
                   'max(abs([SimMin,SimMax]))',...
                   'Binary point'};
        if any(overflow)
            legends = {legends{:},'Overflow'};
        end
        if any(underflow)
            legends = {legends{:},'Underflow'};
        end
        legend(legends,...
               'Location','NorthEastOutside');

        ylim = [0, I_last(1)-I_first(1)+2];
        if ylim(2)>1
            set(gca,'YLim',ylim);
        end
        xlim = get(gca,'XLim');
        % line(xlim,[8,8],'Color','r');
        % line(xlim,[16,16],'Color','r');
        % line(xlim,[24,24],'Color','r');
        % line(xlim,[32,32],'Color','r');
        % line(xlim,[40,40],'Color','r');
        set(gca,'YTick',0:2:ylim(2));
        set(gca,'YGrid','on');
        colormap(flipud(bone));
        axis xy
        title('Histogram extent')
        ylabel('Powers of two')
        set(gcf,'WindowButtonDownFcn',{@DatatypeVisualizer.display_expression_callback,E,ylim})
        set(gca,'XTick',1:length(Index));
        xticklabel = cell(size(Index));
        for n=1:length(Index)
            xticklabel{n} = int2str(Index(n));
        end
        set(gca,'XTickLabel',xticklabel)
        set(gca,'XTick',[])
        set(gca,'XGrid','off')
        set(gca,'YGrid','on')
        orient landscape

        figure(gcf)
    end
    if nargout>0
        varargout{1} = log2_Hist_Aligned;
    end
    
end
