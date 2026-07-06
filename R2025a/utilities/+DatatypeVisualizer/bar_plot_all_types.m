function varargout = bar_plot_all_types(E,T)
% Datatype visualization beta.
    
%   Tom Bryan and Julia Wall, 5 April 2015
%   Copyright 2015-2022 The MathWorks, Inc.

    if nargin<2
        T = DatatypeVisualizer.get_expression_types(E);
    end

    % Extract data from table
    FunctionNames = T.Properties.RowNames;
    [FunctionNames,I] = sort(FunctionNames);
    T = T(I,:);
    ClassNames = T.Properties.VariableNames;
    bins = table2array(T);
    
    % Plot
    if isempty(bins)
        axis_lim = axis;
        h = text(mean(axis_lim(1:2)),mean(axis_lim(3:4)),'NONE');
        set(h,'HorizontalAlignment','center',...
              'VerticalAlignment','middle',...
              'FontSize',14);
        axis off
        if nargout>0
          varargout{1} = [];
    end
    if nargout>1
        varargout{2} = [];
    end
        return
    end

    clf
    set(gcf,'WindowButtonDownFcn',{@DatatypeVisualizer.display_all_from_bar_plot,E});
    colormap(jet)
    if isvector(bins)
        bins2 = [bins;nan(size(bins))];
        h = barh(bins2,'stacked');
     else
        h = barh(bins,'stacked');
    end
    legend(ClassNames,'Interpreter','None')
    DatatypeVisualizer.set_bar_colors(h);
    set(gca,'YTick',1:length(FunctionNames));
    set(gca,'YLim',[0.5,length(FunctionNames)+0.5]);
    
    yticklabel = replace_underscore(FunctionNames);
    set(gca,'YTickLabel',yticklabel)
    
    axis ij
    orient tall
    title('All types in each function','Interpreter','none')
    xlabel('Number of expressions')
    figure(gcf)
    set(gcf,'WindowStyle','Docked')
    
    if nargout>0
        varargout{1} = T;
    end
    if nargout>1
        varargout{2} = h;
    end
end

function A = replace_underscore(A)
    % Replace my_fun with my\_fun so TeX interpreter doesn't make them
    % subscripts.  Backslash is the escape character, so '\_' needs to be
    % escaped to '\\_'. 
    A = regexprep(A,'_','\\_');
end
