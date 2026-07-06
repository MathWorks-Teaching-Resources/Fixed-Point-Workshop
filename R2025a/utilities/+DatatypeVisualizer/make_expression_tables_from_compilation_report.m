function [E,V] = make_expression_tables_from_compilation_report(CompilationReport)
% Datatype visualization beta.
    
%   Tom Bryan and Julia Wall, 5 April 2015
%   Copyright 2015-2022 The MathWorks, Inc.

    
    E = DatatypeVisualizer.make_expression_table(CompilationReport);
    V = DatatypeVisualizer.make_variable_table(CompilationReport);
% The meaning of the histogram bins: [-128,127];

end
