function S = svdAnySize(A, econFlag, matrixFlag)
    %svdAnySize Singular value decomposition of any size matrix.
    %   S = fixed.internal.svd.s.svdAnySize(A, econFlag, matrixFlag)
    %   computes the singular value decomposition of any size matrix.

    %   Copyright 2022 The MathWorks, Inc.
    %#codegen

    [m,n] = size(A);
    if m < n
        S = fixed.internal.svd.s.svdShortFat( A, econFlag, matrixFlag);
    else
        S = fixed.internal.svd.s.svdSquareOrTallSkinny(A, econFlag, matrixFlag);
    end
end

