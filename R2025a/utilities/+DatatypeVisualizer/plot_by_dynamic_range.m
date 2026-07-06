function varargout = plot_by_dynamic_range(E,fun_name,my_title)
% Datatype visualization beta.
    
%   Tom Bryan and Julia Wall, 5 April 2015
%   Copyright 2015-2022 The MathWorks, Inc.

    if nargin<2, fun_name=''; end
    if nargin<3
        my_title=['Expresssions sorted by dynamic range,' ...
                  'then magnitude']; 
    end

    [E,...
     ~,...
     log2_Eps,...
     log2_MaxAbsSim,...
     log2_MaxAbsRange,...
     log2_HistCombined,...
     underflow,...
     overflow] = DatatypeVisualizer.expression_table_to_vars(E);
    
    PaleGreen = [152,251,152]/255;
    SkyBlue = [135,206,250]/255;
    pink = [1 0.78 0.80]; %#ok<*NASGU>
    
    out_of_bound_color = SkyBlue;
    max_abs_sim_color = PaleGreen;

    t = 1:length(log2_MaxAbsRange);
    zero = 129;

    [dynamic_range, I_first, I_last] = DatatypeVisualizer.find_dynamic_range(log2_HistCombined);
    x = [E.SimMax E.SimMin];
    x = max(abs(x)');
    [~,I] = sortrows([dynamic_range,x(:)],[1,-2]);
    I_first = I_first(I);
    I_last = I_last(I);
    E = E(I,:);
    
    DatatypeVisualizer.plot_expression_table(E,fun_name,my_title);
    if nargout>0
        varargout{1} = E;
    end
end
