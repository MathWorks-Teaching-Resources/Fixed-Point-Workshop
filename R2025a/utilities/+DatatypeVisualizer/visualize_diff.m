function visualize_diff(fig,plot_fun,E1,E2,label,plot_expression_names,dt,dto)
%

%   Copyright 2022 The MathWorks, Inc.

    global PLOT_EXPRESSION_NAMES
    PLOT_EXPRESSION_NAMES = plot_expression_names;
    figure(fig)
    clf
    feval(plot_fun,E1,E2);
    label = sprintf('%s (%s,%s)',label,dt,dto);
    h = title(label);
    set(h,'Interpreter','none');
    set(gcf,'Name',label,'WindowStyle','Docked');
    addToolbarExplorationButtons(fig);
    drawnow
end
