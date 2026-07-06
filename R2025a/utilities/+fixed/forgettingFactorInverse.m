function m = forgettingFactorInverse(alpha)
%fixed.forgettingFactorInverse Forgetting factor inverse
%   m = fixed.forgettingFactorInverse(alpha) returns the
%   number of rows m of a matrix with equivalent gain corresponding
%   to forgetting factor alpha.

%   Copyright 2021 The MathWorks, Inc.
    narginchk(1,1);
    m = round(-1/(2*log(double(alpha))));
end