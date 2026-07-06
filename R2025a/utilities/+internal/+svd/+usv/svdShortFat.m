function [U, S, V] = svdShortFat( A, econFlag, matrixFlag)
    %svdShortFat Singular value decomposition on short, fat matrix.
    %   [U,S,V] = fixed.internal.svd.usv.svdShortFat(A, econFlag, matrixFlag) 
    %   computes the singular value decomposition on matrix A, where the number
    %   of rows of A is less than the number of columns of A.

    %   Copyright 2022 The MathWorks, Inc.
    %#codegen

    % Compute the square or tall and skinny SVD of the transposed problem for
    % short-fat matrices. Note that U and V trade places.
    [ V, S_transpose, U] = fixed.internal.svd.usv.svdSquareOrTallSkinny( A', econFlag, matrixFlag);
    if matrixFlag
        S = S_transpose';
    else
        S = S_transpose;
    end
end