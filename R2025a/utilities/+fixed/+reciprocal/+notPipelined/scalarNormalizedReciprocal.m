function [y,t] = scalarNormalizedReciprocal(u)
%scalarNormalizedReciprocal Normalized reciprocal operating on scalars.
%   [y,t] = scalarNormalizedReciprocal(u) returns y and t such that
%
%       (2^t)*y = 1/u,
%
%   and
%
%       0.5 < |y| <= 1.
%
%   If u = 0 and u is fixed-point or scaled-double, then y = 2 - eps(y).
%
%   If u = 0 and u is a floating-point type, then y = inf.
%
%   If u~=0, this function returns the equivalent of
%
%      [y,t] = log2(1/abs(u))
%      if u<0
%         y = -y;
%      end
%
%   except that it is computed using only shifts and adds.
%
%   Example:
%     u = fi(pi)
%     [y,t] = fixed.reciprocal.notPipelined.scalarNormalizedReciprocal(u)
%
%   See also fi, normalizedReciprocal.

%   Copyright 2019 The MathWorks, Inc.
%#codegen

% Normalized reciprocal operating only on scalar input.
    [u, isNegative] = fixed.reciprocal.pipelined.makeRealScalarPositive(u);
    % The input is now positive, so you can use positiveNormalizedReciprocal.
    [y,t] = fixed.reciprocal.notPipelined.scalarPositiveNormalizedReciprocal(u);
    if isNegative
        y(:) = -y;
    end
end
