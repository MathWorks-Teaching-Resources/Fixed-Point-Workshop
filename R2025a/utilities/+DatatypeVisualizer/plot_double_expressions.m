function DE = plot_double_expressions(E,fun_name,my_title)
% Datatype visualization beta.
    
%   Tom Bryan and Julia Wall, 5 April 2015
%   Copyright 2015-2022 The MathWorks, Inc.


    if nargin<2, fun_name=''; end
    if nargin<3
        my_title = 'Double or unknown types';
    end

    DE = E(strcmp(E.Class,'double'),:);

    DatatypeVisualizer.plot_expressions_max_to_min(DE,fun_name,my_title);

end
