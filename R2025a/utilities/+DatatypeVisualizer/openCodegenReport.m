function openCodegenReport(function_name)
% Datatype visualization beta.
    
%   Tom Bryan and Julia Wall, 5 April 2015
%   Copyright 2015-2022 The MathWorks, Inc.

    html_directory = fullfile(pwd,...
                              'codegen',...
                              'lib',...
                              function_name,...
                              'html');
    mainhtml = fullfile(html_directory,'index.html');
    emlcprivate('emcOpenReport',mainhtml);
end

