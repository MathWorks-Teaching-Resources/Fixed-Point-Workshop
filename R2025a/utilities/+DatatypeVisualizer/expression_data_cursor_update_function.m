function cursor_text = expression_data_cursor_update_function(~,event_obj,E,xlimit,ylimit) %#ok<INUSL>
% Datatype visualization beta.
    
%   Tom Bryan and Julia Wall, 5 April 2015
%   Copyright 2015-2022 The MathWorks, Inc.

    global DEBUG
    persistent previous_x_position

    cyan = [0,255,255]/255; %#ok<NASGU>
    LightBlue = [173,216,230]/255; %#ok<NASGU>
    LightGray = 240*[1,1,1]/255;
    highlight_color = [0 0 0];
    vertical_line_color = LightGray;


    if ~isempty(previous_x_position)
        line([previous_x_position-0.5, previous_x_position-0.5],...
             ylimit,...
             'Color',vertical_line_color,...
             'LineWidth',1);
        line([previous_x_position+0.5, previous_x_position+0.5],...
             ylimit,...
             'Color',vertical_line_color,...
             'LineWidth',1);
    end
    pos = get(event_obj,'Position');
    ticklabels = get(gca,'XTickLabel');
    x_position = round(pos(1));
    line([x_position-0.5, x_position-0.5],...
         ylimit,...
         'Color',highlight_color,...
         'LineWidth',1);
    line([x_position+0.5, x_position+0.5],...
         ylimit,...
         'Color',highlight_color,...
         'LineWidth',1);
    index = eval(ticklabels{x_position});
    T_entry = table2struct(E(E.Index==index,:));
    fileName = T_entry.ScriptPath;
    [~,function_name,~] = fileparts(fileName); %#ok<ASGLU>
    lineNumber = T_entry.LineNumber(1);
    DatatypeVisualizer.goToPositionAndHighlight(fileName, lineNumber, T_entry.TextBegin, T_entry.TextEnd);
    cursor_text = DatatypeVisualizer.get_cursor_text(T_entry);

    if DEBUG
        T_entry %#ok<NOPRT>
    end
    previous_x_position = x_position;
end
