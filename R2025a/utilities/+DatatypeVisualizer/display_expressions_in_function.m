function display_expressions_in_function(~,~,E,x_or_y)
% Datatype visualization beta.
    
%   Tom Bryan and Julia Wall, 5 April 2015
%   Copyright 2015-2022 The MathWorks, Inc.

    [x,y] = ginput(1);
    switch x_or_y
        case 'X'
            index = x;
        case 'Y'
            index = y;
        otherwise
            error('x_or_y must be either ''X'' or ''Y''');
    end
    
    ticklabels = get(gca,[x_or_y,'TickLabel']);
    function_name = ticklabels{round(index)};
    T_entry = E(strfind(E.FunctionName,function_name,'ScriptPath'));
    fileName = T_entry.ScriptPath{1};
    lineNumber = T_entry.LineNumber(1);
    DatatypeVisualizer.goToPositionAndHighlight(fileName, lineNumber, T_entry.TextBegin, T_entry.TextEnd);
    % @todo fileName = DatatypeVisualizer.fixup_path_for_computer_mathworks_specific(fileName - Brenda Zhuang);
%     matlab.desktop.editor.openAndGoToLine(fileName, lineNumber);
end


