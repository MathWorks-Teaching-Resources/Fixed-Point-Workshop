function O = plot_overflow_by_function(E)
% Datatype visualization beta.
    
%   Tom Bryan and Julia Wall, 5 April 2015
%   Copyright 2015-2022 The MathWorks, Inc.

    O = E(E.Overflow,:);

    DatatypeVisualizer.plot_by_function(O);
end
