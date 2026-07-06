function display_unknown_and_double_types(~,~,E)
% Datatype visualization beta.
    
%   Tom Bryan and Julia Wall, 5 April 2015
%   Copyright 2015-2022 The MathWorks, Inc.

    [~,y] = ginput(1);
    ticklabels = get(gca,'YTickLabel');
    
    fun_name = delete_latex(ticklabels{round(y)});
    
    DatatypeVisualizer.plot_unknown_and_double_whole_numbers(E,fun_name);
    DatatypeVisualizer.plot_unknown_and_double_non_whole_numbers(E,fun_name);
    DatatypeVisualizer.plot_expressions_sorted_by_type(E,fun_name);
end

function A = delete_latex(A)
    A = regexprep(A,'\\_','_');
end
