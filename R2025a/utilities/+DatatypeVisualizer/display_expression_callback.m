function display_expression_callback(~,~,E,ylimit)
% Datatype visualization beta.
    
%   Tom Bryan and Julia Wall, 5 April 2015
%   Copyright 2015-2022 The MathWorks, Inc.

    persistent anno
    persistent previous_line_1
    persistent previous_line_2

    cyan = [0,255,255]/255;
    LightBlue = [173,216,230]/255;
    LightGray = 240*[1,1,1]/255;
    highlight_color = [0 0 0];
    vertical_line_color = LightGray;

    if ~isempty(anno) && isvalid(anno)
        delete(anno)
    end
    
    if ~isempty(previous_line_1)
        delete(previous_line_1);
        delete(previous_line_2);
    end
    
    %get input from mouse
    try
        disp('Left-click in figure, or press RETURN or Control-C to cancel.')
        [x,~,mbutton] = ginput(1);
    catch
        % User control-c'd out of waiting for input, or the figure
        % was closed.
        return
    end
    if isempty(x)
        % User pressed RETURN key instead of clicking on the figure
        return
    end
    x = round(x);
    previous_line_1 = line([x-0.5, x-0.5],...
         ylimit,...
         'Color',highlight_color,...
         'LineWidth',1);
    previous_line_2 = line([x+0.5, x+0.5],...
         ylimit,...
         'Color',highlight_color,...
         'LineWidth',1);

    ticklabels = get(gca,'XTickLabel');
    index = eval(ticklabels{x});
    T_entry = E(E.Index==index,:);
    disp(' ');
    disp(repmat('=',1,50));
    display_table_entry(T_entry);
    
    %    if mbutton ~= 1
        fileName = T_entry.ScriptPath{1};
        lineNumber = T_entry.LineNumber(1);
        DatatypeVisualizer.goToPositionAndHighlight(fileName, lineNumber, T_entry.TextBegin, T_entry.TextEnd);
%         if ~isempty(fileName) && ~isnan(lineNumber)
%             % @todo fileName = DatatypeVisualizer.fixup_path_for_computer_mathworks_specific(fileName - Brenda Zhuang);
%             matlab.desktop.editor.openAndGoToLine(fileName, lineNumber);
%         end
        %    end 
    
    cursor_text = DatatypeVisualizer.get_cursor_text(T_entry);
    gca_pos = get(gca,'Position');
    anno = annotation('textbox',[gca_pos(3)+.12 gca_pos(2)+0.0 0.4 0.5],...
               'Interpreter','none',...
               'String',cursor_text,...
               'BackgroundColor','w');

end

function display_table_entry(E)

if isfield(E,'LogReason')
    disp(E(:,{'Expression','Index','FunctionName','FunctionID','Size','Class', ...
              'Complex','Signed','WordLength','FractionLength',...
              'MinRange','MaxRange',...
              'SimMin','SimMax','IsAlwaysWholeNumber',...
              'LoggedField','LogReason'}))
else 
   disp(E(:,{'Expression','Index','FunctionName','FunctionID','Size','Class', ...
              'Complex','Signed','WordLength','FractionLength',...
              'MinRange','MaxRange',...
              'SimMin','SimMax','IsAlwaysWholeNumber',...
              'LoggedField'})) 
end 
%    log2_range = log2(max(abs([E.SimMin;E.SimMax]))) %#ok<NASGU,NOPRT>

end
