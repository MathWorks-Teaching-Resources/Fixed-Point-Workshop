function openInstrumentationResults(mex_file_name,root_directory)
% Datatype visualization beta.
    
%   Tom Bryan and Julia Wall, 5 April 2015
%   Copyright 2015-2022 The MathWorks, Inc.

    if nargin<2
        html_directory = fullfile(pwd,...
            'instrumentation',...
            mex_file_name,...
            'html');
    else
        html_directory = fullfile(pwd,...
            root_directory,...
            mex_file_name,...
            'html');
    end
    mainhtml = fullfile(html_directory,'index.html');
    printablehtml = fullfile(html_directory,'printable.html');
    %web('-browser',printablehtml);
    emlcprivate('emcOpenReport',mainhtml);
end
