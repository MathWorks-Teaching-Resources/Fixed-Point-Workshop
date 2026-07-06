function [x,h] = plot_ribbon_expressions(E,fun_name,my_title)
% Datatype visualization beta.
    
%   Tom Bryan and Julia Wall, 5 April 2015
%   Copyright 2015-2022 The MathWorks, Inc.

    
    if nargin<2, fun_name=''; end
    if nargin<3, my_title=''; end
    
    if ~isempty(fun_name)
        E = E(strcmp(E.FunctionName,fun_name),:);
        my_title = [my_title,' (',fun_name,')'];
    end
    
        zero = 129;

    
    [E,...
        Index,...
        log2_Eps,...
        log2_MaxAbsSim,...
        log2_MaxAbsRange,...
        log2_HistCombined,...
        underflow,...
        overflow] = DatatypeVisualizer.expression_table_to_vars(E);

    [dynamic_range, I_first, I_last] = DatatypeVisualizer.find_dynamic_range(log2_HistCombined);
    x = [E.SimMax E.SimMin];
    x = max(abs(x)');
    [~,I] = sortrows([dynamic_range,x(:)],[1,-2]);
    I_first = I_first(I);
    I_last = I_last(I);
    E = E(I,:);
    
    [E,...
        Index,...
        log2_Eps,...
        log2_MaxAbsSim,...
        log2_MaxAbsRange,...
        log2_HistCombined,...
        underflow,...
        overflow] = DatatypeVisualizer.expression_table_to_vars(E);

    finite_max_abs = log2_MaxAbsSim(isfinite(log2_MaxAbsSim));
    ylimit = get_y_limit(finite_max_abs,log2_HistCombined,zero);
    
    t = -128:127;
    
    x = log2_HistCombined;

%     figure(1)
    clf
    colormap(jet);
    h = ribbon(x);
    set(h,'LineStyle','none');
    set(gca,'ylim',ylimit);
    set(gcf,...
        'units','normalized',...
        'outerposition',[0 0 1 1]);
    
    
%     figure(2)
%     plot(t,log2_HistCombined);
%     set(gca,'XDir','reverse','xlim',[-70 10]);
%     set(gcf,...
%         'units','normalized',...
%         'outerposition',[0 0 1 1]);
% 
%     figure(3)
%     h = waterfall(log2_HistCombined);
%     colormap(jet);
%     set(gca,'ylim',ylimit);
% 
%     set( h, 'LineWidth', 4 );
%     hidden off;
%     set(gcf,...
%         'units','normalized',...
%         'outerposition',[0 0 1 1]);

end

function ylimit = get_y_limit(finite_max_abs,log2_HistCombined,zero)
    ylim2 = ceil(max(finite_max_abs) + zero) + 4;
    I_first = nan(size(log2_HistCombined,2),1);
    I_last = nan(size(log2_HistCombined,2),1);
    for n = 1:size(log2_HistCombined,2)
        first = find(~isnan(log2_HistCombined(:,n)),1,'first');
        if ~isempty(first)
            I_first(n) = first;
            last = find(~isnan(log2_HistCombined(:,n)),1,'last');
            I_last(n) = last;
        end
    end
    ylim1 = floor(min(min(I_first)-zero,min(finite_max_abs))) + zero - 4;
    if mod(zero,2) ~= mod(ylim1,2)
        % Make ylim1 + zero even so the ticks will be even
        ylim1 = ylim1 - 1;
    end
    ylimit = [ylim1 ylim2];
end
