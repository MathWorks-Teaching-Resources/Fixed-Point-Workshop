function cursor_text = get_cursor_text(T_entry)
% Datatype visualization beta.
    
%   Tom Bryan and Julia Wall, 5 April 2015
%   Copyright 2015-2022 The MathWorks, Inc.


    cursor_text = {['FunctionName:',T_entry.FunctionName{1}],...
                   ['Expression: ',T_entry.Expression{1}],...
                   ['SimMin: ',num2str(T_entry.SimMin(1))],...
                   ['SimMax: ',num2str(T_entry.SimMax(1))],...
                   ['MinRange: ',num2str(T_entry.MinRange(1))],...
                   ['MaxRange: ',num2str(T_entry.MaxRange(1))],...
                   ['Eps: ',num2str(T_entry.Eps(1))],...
                   ['IsAlwaysWholeNumber: ',int2str(T_entry.IsAlwaysWholeNumber(1))],...
                   ['Function: ',T_entry.FunctionName{1}],...
                   ['Line Number: ',int2str(T_entry.LineNumber(1))]
                  };
    if isfield(T_entry,'LogReason')
        cursor_text{end+1} = ['LogReason: ',T_entry.LogReason];
    end
    
    if T_entry.Overflow
        cursor_text{end+1} = 'OVERFLOW';
    end
    if T_entry.Underflow
        cursor_text{end+1} = 'UNDERFLOW';
    end
    Prototype = T_entry.Prototype{1};
    if isfi(Prototype)
        cursor_text{end+1} = ['Type: ',tostring(Prototype.numerictype)];
    else
        cursor_text{end+1} = ['Type: ',class(Prototype)];
    end

end
