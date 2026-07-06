function alpha = forgettingFactor(m)
%fixed.forgettingFactor Forgetting factor
%   alpha = fixed.forgettingFactor(m) returns the
%   forgetting factor alpha for an infinite number of rows with the
%   equivalent gain of a matrix with m rows.

%   Copyright 2021 The MathWorks, Inc.
    narginchk(1,1);
    alpha = exp(-1/(2*double(m)));
end