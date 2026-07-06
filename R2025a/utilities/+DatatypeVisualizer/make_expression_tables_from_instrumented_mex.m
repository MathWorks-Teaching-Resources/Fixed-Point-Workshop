function [E,V,CompilationReport]= make_expression_tables_from_instrumented_mex(mex_name)
% Datatype visualization beta.
    
%   Tom Bryan and Julia Wall, 5 April 2015
%   Copyright 2015-2022 The MathWorks, Inc.

    
    results = fixed.internal.InstrumentationManager.getResults(mex_name);
    CompilationReport = fixed.internal.processInstrumentedMxInfoLocations(results);    

    [E,V] = DatatypeVisualizer.make_expression_tables_from_compilation_report(CompilationReport);

end   
