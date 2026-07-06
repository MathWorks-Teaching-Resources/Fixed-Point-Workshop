function [U, S, V] = svdAnySize(A, econFlag, matrixFlag)
    %svdAnySize Singular value decomposition of any size matrix.
    %   [U,S,V] = fixed.internal.svd.usv.svdAnySize(A, econFlag, matrixFlag)
    %   computes the singular value decomposition of any size matrix.

    %   Copyright 2022 The MathWorks, Inc.
    %#codegen

    [m,n] = size(A);
    if m < n
        [U, S, V] = fixed.internal.svd.usv.svdShortFat( A, econFlag, matrixFlag);
    else
        [U, S, V] = fixed.internal.svd.usv.svdSquareOrTallSkinny( A, econFlag, matrixFlag);
    end
end

