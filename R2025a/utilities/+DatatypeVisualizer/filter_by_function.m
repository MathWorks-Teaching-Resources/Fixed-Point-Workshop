function [E,V] = filter_by_function(visualizer,fun_name)
%

%   Copyright 2022 The MathWorks, Inc.

    E = visualizer.Expressions;
    V = visualizer.Variables;
    E = E(strcmp(E.FunctionName,fun_name),:);
    V = V(strcmp(V.FunctionName,fun_name),:);
end
