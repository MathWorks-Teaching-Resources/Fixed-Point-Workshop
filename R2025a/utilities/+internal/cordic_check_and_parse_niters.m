function numIters_dbl = cordic_check_and_parse_niters(niters, fcnStr)
%CORDIC_CHECK_AND_PARSE_NITERS Argument parsing for CORDIC NITERS argument
%   NITERS may be empty, inf, or a real positive integer-valued scalar.

% Copyright 2009-2011 The MathWorks, Inc.
%   

numIters_dbl = inf; % default

if ~isempty(niters)
    doErrorHandling(...
        ~(isscalar(niters) && isnumeric(niters) && isreal(niters)),fcnStr);
    
    if isfinite(niters)
        % NITERS specified as scalar, numeric, real, and finite
        doErrorHandling( ...
            ~(isequal(floor(niters), niters) && (niters > 0)), fcnStr);
        
        % NITERS specified as a scalar, real, positive integer value
        numIters_dbl = double(niters);
    else
        % Inf or NaN
        doErrorHandling(isnan(niters), fcnStr);
    end
end

% ===============================================================
function doErrorHandling(doThrowError, fcnStr)
if doThrowError
    msgID = message('fixed:cordic:invalidNiters', fcnStr);
    error(msgID);    
end

