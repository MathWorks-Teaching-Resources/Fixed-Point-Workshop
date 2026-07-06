function visualize_log_reason(fig,log_reasons,plot_fun,E,label,plot_expression_names,dt,dto)
%

%   Copyright 2022-2023 The MathWorks, Inc.

    global PLOT_EXPRESSION_NAMES
    if nargin<7
        dt = '';
    end
    if nargin<8
        dto = '';
    end

    PLOT_EXPRESSION_NAMES = plot_expression_names;
    hFigure = figure(fig);
    clf
    I = false(height(E),1);
    for n = 1:length(log_reasons)
        I = I | strcmp(E.LogReason,log_reasons{n});
    end
    R = E(I,:);
    if isempty(R)
        text(0.5,0.5,'NONE')
    else
        feval(plot_fun,R);
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
    set(hFigure,'Name',label,'WindowStyle','Docked');
    addToolbarExplorationButtons(hFigure);
    drawnow
end
