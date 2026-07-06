function tol = svdTolerance(d)
    %svdTolerance  Tolerance for the fixed-point svd convergence criterion.
    %   tol = fixed.internal.svd.svdTolerance(d) returns the tolerance for the
    %   fixed-point svd convergence criterion for the bidiagonal Golub-Kahan
    %   step (Algorithm 8.6.1, p. 491, Gene Golub and Charles Van Loan, Matrix
    %   Computations, 4th edition).  The epsilon of the tolerance is the eps of
    %   the diagonal element d.
    % 
    %   It is based on the tolerance from LAPACK [scdz]bdsqr.f.  It is the
    %   desired relative precision in the computed singular values.  The
    %   reasoning is to lose at either one eighth or two of the available
    %   decimal digits in each computed singular value (whichever is smaller).

    %   Copyright 2022 The MathWorks, Inc.
    %#codegen

    % Protect against high-precision fixed-point types from not being
    % able to represent their eps in a double without underflow.
    epsilon = max(eps, double(eps(cast(1,'like',d))));
    tolmul = max(10, min(100, epsilon^(-1/8)));
    tol = tolmul * epsilon;

    tol = coder.const(cast(tol,'like',d));
end