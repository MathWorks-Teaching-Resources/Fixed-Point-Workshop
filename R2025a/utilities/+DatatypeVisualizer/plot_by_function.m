function varagout = plot_by_function(E)
%

%   Copyright 2022 The MathWorks, Inc.
    
    global EXPRESSION_TABLE_PLOT_FUNCTION
    if isempty(EXPRESSION_TABLE_PLOT_FUNCTION)
        EXPRESSION_TABLE_PLOT_FUNCTION = @DatatypeVisualizer.plot_expression_table;
    end

    % Only plot cells that have a full histogram
    E = E(cellfun(@length,E.HistogramOfPositiveValues)==256,:);
    [function_names,index] = sort(E.FunctionName);
    E = E(index,:);
    
    [varargout{1:nargout}] = EXPRESSION_TABLE_PLOT_FUNCTION(E);
    if isempty(E)
        return
    end
    h_gca = gca;
    ylimit = h_gca.YAxis.Limits;
    last_function_index = 1;
    for n = 1:length(function_names)-1
        if ~isequal(function_names{n},function_names{n+1})
            label_function(function_names{n},n,last_function_index,ylimit);
            last_function_index = n;
        end
    end
    n = length(function_names);
    label_function(function_names{n},n,last_function_index,ylimit);
end

function label_function(function_name,n,last_function_index,ylimit)
    vertical_line_color = 'k'; %LightGray;
    x = n+0.5;
    line([x x],ylimit,...
        'Color',vertical_line_color,...
        'LineWidth',0.001);
    xpos = last_function_index + (n - last_function_index)/2;
    h_text = text(xpos,ylimit(1),function_name);
    lightskyblue4 = [96, 123, 139]/255; % lightskyblue 4
    set(h_text,...
        'HorizontalAlignment','left',...
        'VerticalAlignment','bottom',...
        'Interpreter','none',...
        'Rotation',45,...
        'FontName','Lucida Console',...
        'FontSize',14,...
        'Color',lightskyblue4);
end
