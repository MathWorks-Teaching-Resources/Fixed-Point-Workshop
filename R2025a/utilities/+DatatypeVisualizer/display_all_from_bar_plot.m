function display_all_from_bar_plot(~,~,E)
% Datatype visualization beta.
    
%   Tom Bryan and Julia Wall, 5 April 2015
%   Copyright 2015-2022 The MathWorks, Inc.

    [~,y] = ginput(1);
    ticklabels = get(gca,'YTickLabel');
    
    fun_name = delete_latex(ticklabels{round(y)});
    
    make_all_plots(E,fun_name);
end

function A = delete_latex(A)
    A = regexprep(A,'\\_','_');
end

function make_all_plots(E,fun_name)
    E = E(strcmp(E.FunctionName,fun_name),:);
    
    title_suffix = [' (',fun_name,')'];
    
    %%
    figure;
    TE = DatatypeVisualizer.bar_plot_all_types(E);
    title(['Expressions',title_suffix])
    set(gcf,'WindowStyle','Docked')
    
    figure;
    DatatypeVisualizer.plot_expressions_sorted_by_type(E)
    grid off
    title(['All expressions sorted by type',title_suffix])
    set(gcf,'WindowStyle','Docked')
    
    figure;
    DatatypeVisualizer.plot_by_histogram_range(E(E.IsAlwaysWholeNumber,:));
    grid off
    title(['Always whole number expressions',title_suffix])
    set(gcf,'WindowStyle','Docked')
    
    figure
    DatatypeVisualizer.plot_by_histogram_range(E(~E.IsAlwaysWholeNumber,:));
    grid off
    title(['Not always whole number expressions',title_suffix])
    set(gcf,'WindowStyle','Docked')
    
    figure
    DatatypeVisualizer.plot_by_dynamic_range(E);
    grid off
    title(['Expressions sorted by dynamic range, then type, ' ...
        'then magnitude',title_suffix])
    set(gcf,'WindowStyle','Docked')
    
    DatatypeVisualizer.plot_unknown_and_double_whole_numbers(E,fun_name);
    
    DatatypeVisualizer.plot_unknown_and_double_non_whole_numbers(E,fun_name);
    
end
