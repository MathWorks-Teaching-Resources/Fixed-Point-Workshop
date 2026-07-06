function varargout = plot_expressions_max_to_min(E,fun_name,my_title)
% Datatype visualization beta.
    
%   Tom Bryan and Julia Wall, 5 April 2015
%   Copyright 2015-2022 The MathWorks, Inc.

    global EXPRESSION_TABLE_PLOT_FUNCTION
    if isempty(EXPRESSION_TABLE_PLOT_FUNCTION)
        EXPRESSION_TABLE_PLOT_FUNCTION = @DatatypeVisualizer.plot_expression_table;
    end

    if nargin<2, fun_name=''; end
    if nargin<3, my_title=''; end

    x = [E.SimMax E.SimMin];
    x = max(abs(x)');
    [~,I] = sort(x,'descend');
    S = E(I,:);
    EXPRESSION_TABLE_PLOT_FUNCTION(S,fun_name,my_title);
    if nargout>0
        varargout{1} = S;
    end
end
