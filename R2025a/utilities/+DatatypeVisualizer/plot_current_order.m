function varargout = plot_current_order(E,fun_name,my_title)
% Datatype visualization beta.
    
%   Tom Bryan and Julia Wall, 5 April 2015
%   Copyright 2015-2022 The MathWorks, Inc.


    if nargin<2, fun_name=''; end
    if nargin<3, my_title=''; end
    
    DatatypeVisualizer.plot_expression_table(E,fun_name,my_title);
    if nargout>0
        varargout{1} = E;
    end
end
