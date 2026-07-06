function varargout = setModelWorkspace(model,varargin)
%setModelWorkspace Set model workspace variables
%   fixed.example.setModelWorkspace(model,'variable_name1',variable_value1, ...)
%   sets model workspace of model to the variables specified by
%   name and value.
%
%   mdlWks = fixed.example.setModelWorkspace(___) returns a model
%   workspace object.

%   Reference: https://www.mathworks.com/help/simulink/ug/change-model-workspace-data.html
%   Copyright 2021-2022 The MathWorks, Inc.

    load_system(model)
    mdlWks = get_param(model,'ModelWorkspace');
    for k = 1:2:length(varargin)
        assignin(mdlWks,varargin{k},varargin{k+1});
    end
    if nargout>0
        varargout{1} = mdlWks;
    end
end
