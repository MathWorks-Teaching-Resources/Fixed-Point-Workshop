function maxiter = svdMaximumNumberOfIterations(n)
    %svdMaximumNumberOfIterations Maximum number of iterations for svd to converge.
    %   fixed.internal.svd.svdMaximumNumberOfIterations(n) returns the maximum
    %   number of iterations to allow in the bidiagonal Golub-Kahan
    %   step (Algorithm 8.6.1, p. 491, Gene Golub and Charles Van Loan, Matrix
    %   Computations, 4th edition) before declaring that it did not converge.
    % 
    %   It is based on the maximum number of iterations from LAPACK [scdz]bdsqr.f.

    %   Copyright 2022 The MathWorks, Inc.
    %#codegen
        
    % Cast to int32 instead of coder.internal.indexInt because
    % indexInt can wrap to a negative value if 6*n*n overflows.
    % There is no penalty for using int32 since this function
    % returns a constant.  This bounds the maximum number of
    % iterations to intmax('int32'), which is big enough for all
    % practical purposes.
    maxiter = coder.const(int32(6)*int32(n)*int32(n));
end
