function mdlWks = setModelWorkspace(model,varargin)
    % https://www.mathworks.com/help/simulink/ug/change-model-workspace-data.html
    load_system(model)
    mdlWks = get_param(model,'ModelWorkspace');
    for k = 2:nargin
        assignin(mdlWks,inputname(k),varargin{k-1});
    end
end