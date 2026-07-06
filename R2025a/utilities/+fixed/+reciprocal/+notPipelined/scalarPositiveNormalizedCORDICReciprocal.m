function y = scalarPositiveNormalizedCORDICReciprocal(x)
%positiveNormalizedCORDICReciprocal Positive normalized reciprocal
%   [y, t, validOut] = positiveNormalizedCORDICReciprocal(x, t_in, validIn)
%   produces y = 1/x when 1 <= x < 2, and t = t_in.
%
%   When x = 0 and x is fixed-point or scaled-double, then y = 2 - eps(y).
%
%   When x = 0 and x is a floating-point type, then y = inf.
%
%   If x is fixed-point, then y is fixed-point with
%   numerictype(1, x.WordLength, x.WordLength - 2).
%
%   If x is floating-point, then y is floating-point of the same type.
%
%   References:
%
%   [1] Jack E. Volder, "The CORDIC Trigonometric Computing Technique," IRE
%       Transactions on Electronic Computers, Volume EC-8, September 1959,
%       pp. 330-334.
%
%   [2] J.S. Walther, "A Unified Algorithm for Elementary Functions,"
%       Conference Proceedings, Spring Joint Computer Conference, May 1971,
%       pp. 379-385.
%
%   See also normalizedReciprocal.

%   Copyright 2019 The MathWorks, Inc.
%#codegen
    fixed.internal.reciprocal.validateReciprocalInputs(x, true);
    if isfi(x) && isscaledtype(x)
        % CORDIC reciprocal for fixed-point and scaled-double types
        y = fixed.reciprocal.notPipelined.cordicReciprocalKernel(x);
    else
        % y = 1/x for builtin types.
        y = 1./x;
    end
end
