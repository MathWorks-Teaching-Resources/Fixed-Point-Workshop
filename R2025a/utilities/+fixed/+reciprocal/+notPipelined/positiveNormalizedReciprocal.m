function [y,t] = positiveNormalizedReciprocal(u)
%positiveNormalizedReciprocal Normalized reciprocal for positive inputs only.
%   [y,t] = positiveNormalizedReciprocal(u) returns y and t such that
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
    [y1,t1] = fixed.reciprocal.notPipelined.scalarPositiveNormalizedReciprocal(u(1));
    if numel(u) == 1
        y = y1;
        t = t1;
    else
        t = zeros(size(u),'like',t1);
        t(1) = t1;
        y = zeros(size(u),'like',y1);
        y(1) = y1;
        for k = 2:numel(u)
            [y(k),t(k)] = fixed.reciprocal.notPipelined.scalarPositiveNormalizedReciprocal(u(k));
        end
    end
end
