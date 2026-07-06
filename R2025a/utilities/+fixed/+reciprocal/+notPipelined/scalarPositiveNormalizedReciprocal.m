function [y,t] = scalarPositiveNormalizedReciprocal(u)
%scalarPositiveNormalizedReciprocal Normalized reciprocal for scalar, positive inputs only.
%   [y,t] = scalarPositiveNormalizedReciprocal(u) returns y and t such that
%
%       (2^t)*y = 1/u,
%
%   and
%
%       0.5 < y <= 1.
%
%   If u = 0 and u is fixed-point or scaled-double, then y = 2 - eps(y).
%
%   If u = 0 and u is a floating-point type, then y = inf.
%
%   If u>0, this function returns the equivalent of
%
%      [y,t] = log2(1/u)
%
%   except that it is computed using only shifts and adds.
%
%   See also normalizedReciprocal.

%   Copyright 2019 The MathWorks, Inc.
%#codegen
    [x, t] = fixed.reciprocal.notPipelined.scalarPositiveRealNormalizer(u);
    y = fixed.reciprocal.notPipelined.scalarPositiveNormalizedCORDICReciprocal(x);
end
