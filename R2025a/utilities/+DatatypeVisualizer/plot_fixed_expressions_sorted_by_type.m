function varargout = plot_fixed_expressions_sorted_by_type(E,fun_name,my_title)
% Datatype visualization beta.
    
%   Tom Bryan and Julia Wall, 5 April 2015
%   Copyright 2015-2022 The MathWorks, Inc.


    if nargin<2, fun_name=''; end
    if nargin<3, my_title=''; end
    
    % Remove double, single, unknown types
    E = E(~(strcmp(E.Class,'double')|strcmp(E.Class,'single')|strcmp(E.Class,'')),:);

    x = [E.SimMax E.SimMin];
    x = max(abs(x)')';
    [~,I] = sortrows([E.WordLength,E.FractionLength,x],[-1,2,-3]);
    S = E(I,:);
    DatatypeVisualizer.plot_expression_table(S,fun_name,my_title);
    if nargout>0
        varargout{1} = S;
    end
end
