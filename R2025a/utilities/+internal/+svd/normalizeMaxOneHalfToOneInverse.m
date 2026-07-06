function y = normalizeMaxOneHalfToOneInverse(u_normalized,e,n_normalized,u)
    %normalizeMaxOneHalfToOneInverse Inverse of function normalizeMaxOneHalfToOne.
    %    y = fixed.internal.svd.normalizeMaxOneHalfToOneInverse(u_normalized,e,n_normalized,u)
    %    reverses the normalization from
    %    fixed.internal.svd.normalizeMaxOneHalfToOne.

    %   Copyright 2022 The MathWorks, Inc.
    %#codegen
    y = zeros(size(u_normalized),'like',removefimath(real(u)));
    if isfi(u) && isfixed(u)
        y(:) = reinterpretcast(u_normalized,u.numerictype);
        y(:) = fixed.bitshift(y,-n_normalized);
    else
        y(:) = fixed.bitshift(u_normalized,-e);
    end
end