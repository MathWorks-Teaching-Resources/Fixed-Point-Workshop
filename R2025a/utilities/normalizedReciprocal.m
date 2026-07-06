function [y,e] = normalizedReciprocal(u)
%normalizedReciprocal Normalized reciprocal.
%   [y,e] = normalizedReciprocal(u) returns y and e such that
%
%       (2.^e).*y = 1./u,
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
%      [y,e] = log2(1./abs(double(u)))
%      y(u<0) = -y(u<0)
%
%   except that it is computed using only shifts and adds.
%
%   Example:
%     u = fi([-pi,0.01,pi])
%     [y,e] = normalizedReciprocal(u)
%
%   See also fi.

%   Copyright 2019 The MathWorks, Inc.
%#codegen
    [y1,e1] = fixed.reciprocal.notPipelined.scalarNormalizedReciprocal(u(1));
    y = zeros(size(u),'like',y1);
    y(1) = y1;
    e = zeros(size(u),'like',e1);
    e(1) = e1;
    for k = 2:numel(u)
        [y(k),e(k)] = fixed.reciprocal.notPipelined.scalarNormalizedReciprocal(u(k));
    end
end

