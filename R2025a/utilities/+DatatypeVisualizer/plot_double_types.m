function T = plot_double_types(E,T)
% Datatype visualization beta.
    
%   Tom Bryan and Julia Wall, 5 April 2015
%   Copyright 2015-2022 The MathWorks, Inc.


    if nargin<2
        T = DatatypeVisualizer.get_expression_types(E);
    end
    % Extract data from table
    D = T(:,{'Unknown','double'});
    FunctionNames = D.Properties.RowNames;
    ClassNames = D.Properties.VariableNames;
    
    bins = table2array(D);
    
    % Plot
    clf
    set(gcf,'WindowButtonDownFcn',{@DatatypeVisualizer.display_double_types,E});
    colormap(jet)
    barh(bins,'stacked')
    legend(ClassNames,'Interpreter','None')
    set(gca,'YTick',1:length(FunctionNames));
    set(gca,'YTickLabel',FunctionNames)
    axis ij
    axis tight
    orient tall
    title('Expressions of double or unknown type','Interpreter','none')
    xlabel('Number of expressions')
    figure(gcf)
end

