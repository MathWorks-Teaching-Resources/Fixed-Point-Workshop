function [E,V] = make_all_expression_plots_from_instrumented_mex(mex_name,fun_name)
% Datatype visualization beta.
    
%   Tom Bryan and Julia Wall, 5 April 2015
%   Copyright 2015-2022 The MathWorks, Inc.

    
    results = fixed.internal.InstrumentationManager.getResults(mex_name);
    CompilationReport = fixed.internal.processInstrumentedMxInfoLocations(results);    
    [E,V] = DatatypeVisualizer.make_all_expression_plots(CompilationReport,mex_name,fun_name);
    
end
