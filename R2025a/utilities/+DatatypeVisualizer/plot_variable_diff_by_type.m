function [D1,D2] = plot_variable_diff_by_type(E1,E2)
     %global PLOT_EXPRESSION_NAMES
     %current_PLOT_EXPRESSION_NAMES = PLOT_EXPRESSION_NAMES;
     %PLOT_EXPRESSION_NAMES = true; %#ok<NASGU>

%   Copyright 2022 The MathWorks, Inc.

    [D1,D2] = DatatypeVisualizer.variable_diff_by_type(E1,E2);
    
    ax = subplot(211);
    cla
    if ~isempty(D1)
        DatatypeVisualizer.plot_by_function(D1);
    end
    
    ax(2) = subplot(212);
    cla
    if ~isempty(D2)
        DatatypeVisualizer.plot_by_function(D2);
    end
    linkaxes(ax,'xy');
    %PLOT_EXPRESSION_NAMES = current_PLOT_EXPRESSION_NAMES;
end

        
