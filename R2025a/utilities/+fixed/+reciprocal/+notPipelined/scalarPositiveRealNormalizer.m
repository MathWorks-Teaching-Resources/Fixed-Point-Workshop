function [x, e, n_normalized] = scalarPositiveRealNormalizer(u)
%positiveRealNormalizer  Positive real normalizer
%   [x, e, validOut] = positiveRealNormalizer(u, validIn) produces
%   x such that 1 <= x < 2 and e such that x = (2^e)*u when u > 0.
%
%   When u = 0 and u is fixed-point or scaled-double, then x = 0 and
%   e = (2^nextpow2(x.WordLength)) - x.WordLength - x.FractionLength.
%
%   When u = 0 and u is floating-point, then x = 0 and e = 1.
%
%   See also normalizedReciprocal.

%   Copyright 2019-2022 The MathWorks, Inc.
%#codegen

% This function only works on scalars.
% Only operate on the real part
    fixed.internal.reciprocal.validateNormalizerInputs(u, true);
    % Normalize in unsigned type.
    coder.internal.assert(isreal(u),'fixed:emblib:InputMustBeReal','u');
    if isfi(u) && isfixed(u)
        % Normalize fixed-point values
        [x_normalized, n_normalized] = fixed.reciprocal.notPipelined.scalarNormalizePositiveFixedPoint(real(u));
    else
        % Normalize floating-point or scaled-double
        [x_normalized, n_normalized] = fixed.internal.reciprocal.normalizePositiveFloatOrScaledDouble(real(u),true);
    end
    % Cast the output to signed if the input was signed.
    x = fixed.internal.reciprocal.castToInputSignedness(x_normalized,u);
    % Convert the normalized shift value based on the data type of the
    % input U so that the output of the normalizer X is in real-world
    % scale and X = (2^N)*U.
    e = fixed.internal.reciprocal.normalizedShiftToRealWorldValueShift(n_normalized,u);
end
