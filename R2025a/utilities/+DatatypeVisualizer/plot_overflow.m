function plot_overflow(E)
% Datatype visualization beta.
    
%   Tom Bryan and Julia Wall, 5 April 2015
%   Copyright 2015-2022 The MathWorks, Inc.

    %figure('Name','Overflows')
    DatatypeVisualizer.plot_expression_table(E(E.Overflow,:));

end
