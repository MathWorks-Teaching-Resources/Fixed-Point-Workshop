function test_plots(E,fun_name)
% Datatype visualization beta.
    
%   Tom Bryan and Julia Wall, 5 April 2015
%   Copyright 2015 The MathWorks, Inc.

    if nargin < 2
        fun_name = '';
    end
    
    if ~isempty(fun_name)
        E = E(strcmp(E.FunctionName,fun_name),:);
    end
    
    if isempty(fun_name)
        title_suffix = '';
    else
        title_suffix = [' (',fun_name,')'];
    end

    %%
    % figure;
    % TE = DatatypeVisualizer.bar_plot_all_types(E);
    % title(['Expressions',title_suffix],'Interpreter','none')
    
    
    figure;
    DatatypeVisualizer.plot_expressions_sorted_by_type(E)
    grid off
    title(['Sorted by type',title_suffix],'Interpreter','none')
    
    figure;
    DatatypeVisualizer.plot_by_histogram_range(E(E.IsAlwaysWholeNumber,:));
    grid off
    title(['Histogram extent normalized: Always whole numbers',title_suffix],'Interpreter','none')
    
    figure
    DatatypeVisualizer.plot_by_histogram_range(E(~E.IsAlwaysWholeNumber,:));
    grid off
    title(['Histogram extent normalized: Not always whole numbers',title_suffix],'Interpreter','none')
    
    figure
    DatatypeVisualizer.plot_by_dynamic_range_type_magnitude(E);
    grid off
    title(['Sorted by dynamic range, then type, ' ...
        'then magnitude',title_suffix])
    
    figure
    DatatypeVisualizer.plot_by_dynamic_range_type_magnitude(E(E.IsAlwaysWholeNumber,:));
    grid off
    title(['Always whole numbers sorted by dynamic range, then type, ' ...
        'then magnitude',title_suffix])

    figure
    DatatypeVisualizer.plot_by_dynamic_range_type_magnitude(E(~E.IsAlwaysWholeNumber,:));
    grid off
    title(['Not always whole numbers sorted by dynamic range, then type, ' ...
        'then magnitude',title_suffix])

    figure
    DatatypeVisualizer.plot_by_dynamic_range(E);
    grid off
    title(['Sorted by dynamic range, ' ...
        'then magnitude',title_suffix])
    
    figure
    DatatypeVisualizer.plot_by_dynamic_range(E(E.IsAlwaysWholeNumber,:));
    grid off
    title(['Always whole numbers sorted by dynamic range, ' ...
        'then magnitude',title_suffix])

    figure
    DatatypeVisualizer.plot_by_dynamic_range(E(~E.IsAlwaysWholeNumber,:));
    grid off
    title(['Not always whole numbers sorted by dynamic range, ' ...
        'then magnitude',title_suffix])
    
end
