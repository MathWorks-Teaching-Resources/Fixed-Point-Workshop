function goToPositionAndHighlight(fileName, lineNumber, startPosition, endPosition)
%goToPositionAndHighlight
    
%   Tom Bryan and Julia Wall, 5 April 2015
%   Copyright 2020-2022 The MathWorks, Inc.
    if ~isempty(fileName)
        if ~isempty(startPosition)
            if iscell(startPosition)
                startPosition = startPosition{1}(1);
                endPosition = endPosition{1}(1);
            else
                startPosition = startPosition(1);
                endPosition = endPosition(1);
            end
            if ~isnan(startPosition)
                editor = matlab.desktop.editor.openDocument(fileName); %fileName should be absolute path
                [startLine, startColumn] = matlab.desktop.editor.indexToPositionInLine(editor, startPosition);
                [endLine, endColumn] = matlab.desktop.editor.indexToPositionInLine(editor, endPosition);
                editor.Selection = [startLine startColumn endLine endColumn+1];
            end
        elseif ~isempty(lineNumber) && ~isnan(lineNumber)
            matlab.desktop.editor.openAndGoToLine(fileName, lineNumber)
        end
    end
end
