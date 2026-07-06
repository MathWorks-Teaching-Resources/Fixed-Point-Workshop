function visualize_plot(fig,plot_fun,E,label,plot_expression_names,dt,dto)
%

%   Copyright 2022-2023 The MathWorks, Inc.

    global PLOT_EXPRESSION_NAMES
    if nargin<6
        dt = '';
    end
    if nargin<7
        dto = '';
    end
    PLOT_EXPRESSION_NAMES = plot_expression_names;
    figure(fig)
    clf
    if iscell(E)
        feval(plot_fun,E{:});
    else
        feval(plot_fun,E);
    end
    if isempty(dt) && isempty(dto)
        label = sprintf('%s',label);
    elseif isempty(dt)
        label = sprintf('%s (%s)',label,dto);
    elseif isempty(dto)
        label = sprintf('%s (%s)',label,dt);
    else
        label = sprintf('%s (%s,%s)',label,dt,dto);
    end
    h = title(label);
    set(h,'Interpreter','none');
    set(fig,'Name',label,'WindowStyle','Docked');
    addToolbarExplorationButtons(figure(fig));
    drawnow
end
