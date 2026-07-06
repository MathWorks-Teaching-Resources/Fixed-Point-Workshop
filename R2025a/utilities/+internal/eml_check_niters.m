function eml_check_niters(n, fcnStr)
    %EML_CHECK_NITERS(N, FCNSTR)
    % Basic argument checking for NITERS for CORDIC Iterations. Asserts
    % that N is a compile time constant, that it is numeric, real, finite,
    % positive, and that it is integer valued. Note that it does not check
    % to make sure that it has an integer data type.
    %
    % FCNSTR is the name of the calling function.
    %
    
    %   Copyright 2017 The MathWorks, Inc.
    %#codegen
    
    % Make sure the argument passed in is valid
    coder.internal.assert(~isempty(n) && isscalar(n) && isnumeric(n) && ...
        isreal(n) && isfinite(n) && n > 0 && floor(n) == n,...
        'fixed:cordic:invalidNiters',fcnStr);
end
