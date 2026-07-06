function [u_normalized, e, n_normalized] = normalizeMaxOneHalfToOne(u,bit_growth)
    %normalizeMaxOneHalfToOne Normalize max value to between 1/2 and 1.
    %   [u_normalized, e, n_normalized] = fixed.internal.svd.normalizeMaxOneHalfToOne(u,bit_growth)
    %   normalizes the largest-magnitude element of u to be between 1/2 and 1,
    %   and applies the same normalization to the rest of the elements such
    %   that the real-world-value
    %
    %      u_normalized = u * 2^e
    %
    %   If u is fixed-point, then 
    %
    %      u = bitshift(reinterpretcast(u_normalized,u.numerictype),-n_normalized)
    %
    %   The value bit_growth is the number of additional integer bits to add to
    %   u_normalized.
    %
    %   See also fixed.internal.svd.normalizeMaxOneHalfToOneInverse.

    %   Copyright 2022 The MathWorks, Inc.
    %#codegen
    if nargin < 2
        % When u = b, the compact form of the bidiagonal matrix B,
        % then bit growth is 2 because B is real and bidiagonal.
        bit_growth = 2;
    end
    F = fimath('OverflowAction','Saturate');
    u = setfimath(u,F);
    max_u = max(abs(u(:)));

    [max_u_normalized2, e, n_normalized0] = fixed.reciprocal.notPipelined.scalarPositiveRealNormalizer(max_u);
    n_normalized = cast(n_normalized0,'like',e);
    e(:) = e - 1;

    if isfi(u) && isscaledtype(u)
        max_u_normalized1 = fi([],u.Signed,u.WordLength,u.WordLength - 1);
        wordLength = u.WordLength;
        normalizedFractionLength = max_u_normalized1.FractionLength - bit_growth;
        u_normalized = fi(zeros(size(u)),u.Signed,wordLength,normalizedFractionLength,'DataType',u.DataType);
    else
        u_normalized = zeros(size(u),'like',max_u_normalized2);
    end

    if isfi(u) && isfixed(u)
        is_signed = cast(issigned(u),'like',n_normalized);
        u_shifted = fixed.bitsll(u, n_normalized - is_signed);
        u_shifted_normalized = reinterpretcast(u_shifted, max_u_normalized1.numerictype);
        u_normalized(:) = u_shifted_normalized;
        n_normalized(:) = n_normalized - bit_growth - is_signed;
    else
        u_normalized(:) = fixed.bitshift(u,e);
    end
    u_normalized = removefimath(u_normalized);
end

