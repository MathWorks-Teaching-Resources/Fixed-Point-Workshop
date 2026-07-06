function W = plot_whole_numbers_by_function(E)
% Datatype visualization beta.
    
%   Tom Bryan and Julia Wall, 5 April 2015
%   Copyright 2015-2022 The MathWorks, Inc.

    W = E(E.IsAlwaysWholeNumber,:);

    DatatypeVisualizer.plot_by_function(W);
end
