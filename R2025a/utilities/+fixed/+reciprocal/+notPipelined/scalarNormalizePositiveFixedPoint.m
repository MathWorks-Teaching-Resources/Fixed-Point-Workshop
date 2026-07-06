function [x, t] = scalarNormalizePositiveFixedPoint(u)
%scalarNormalizePositiveFixedPoint Normalize positive fixed-point values, operates on scalars only.
%
%   [x, t] = scalarNormalizePositiveFixedPoint(u)
%
%   Given real scalar u > 0, this function produces x such that
%      1 <= x < 2
%   and t such that
%      x = (2^t)*u.
%
%   If u == 0, then
%      x = 0
%   and
%      t = 2^nextpow2(w) - w + f,
%   where w = u.WordLength and f = u.FractionLength.

%   Copyright 2019 The MathWorks, Inc.
%#codegen

% For fixed-point types, the normalization uses a binary search of
% length log2 of the word length of the input.
    number_of_stages = coder.const(nextpow2(u.WordLength));
    % Constant shift values
    shiftTable = coder.const(fixed.internal.reciprocal.normalizerShiftTable(u.WordLength));
    % Constant bit mask
    mask = coder.const(fixed.internal.reciprocal.normalizerBitMask(u.WordLength));

    % Perform a binary search, looking for the leading non-zero value.
    shift_index = int16(1);

    t = cast(0,'like',fi(0,0,max(number_of_stages,1),0));
    xReg = cast(stripscaling(u),'like',fi([],0,u.WordLength,0));
    for k = 1:number_of_stages
        shift_index = shift_index + 1;
        if bitand(mask(k),xReg) == 0
            % There are all zeros in this slice.  Update the number
            % of shifts taken, and left shift out this slice.
            t = bitset(t, number_of_stages - k + 1);
            xReg = bitsll(xReg,shiftTable(k));
        end
    end
    % Output X in unsigned fractional format
    x = reinterpretcast(xReg(end), numerictype(0,u.WordLength,u.WordLength-1));
end

