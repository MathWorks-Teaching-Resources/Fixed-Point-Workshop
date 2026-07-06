function fileName = fixup_path_for_computer_mathworks_specific(fileName)
    % So Tom's data created on Mac will work on Windows
    
    %   Tom Bryan and Julia Wall, 5 April 2015
    %   Copyright 2015-2022 The MathWorks, Inc.
    if ispc
        strrep(fileName,'/mathworks',[filesep,filesep,'mathworks']);
        strrep(filename,'/',filesep);
    else
        strrep(fileName,'\\mathworks',[filesep,'mathworks']);
        strrep(fileName,'\',filesep);
    end
end
