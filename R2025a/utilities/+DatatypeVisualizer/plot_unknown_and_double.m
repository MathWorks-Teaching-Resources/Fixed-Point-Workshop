function plot_unknown_and_double(E,fun_name,my_title)
% Datatype visualization beta.
    
%   Tom Bryan and Julia Wall, 5 April 2015
%   Copyright 2015-2022 The MathWorks, Inc.


    if nargin<2, fun_name=''; end

    D = E(strcmp(E.Class,'double'),:);
    U = E(strcmp(E.Class,''),:);

    figure
    DatatypeVisualizer.plot_expressions_max_to_min(D,fun_name,['double - ',my_title]);
    figure
    DatatypeVisualizer.plot_expressions_max_to_min(U,fun_name,['Unknown type - ',my_title]);
    

end
