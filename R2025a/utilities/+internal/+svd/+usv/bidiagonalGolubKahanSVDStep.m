function [d_out, f_out, U, V ] = bidiagonalGolubKahanSVDStep(d_in, f_in, U, V)
    %bidiagonalGolubKahanSVDStep Bidiagonal Golub-Kahan SVD Step.
    %   [d, f, U, V ] = fixed.internal.svd.usv.bidiagonalGolubKahanSVDStep(d, f, U, V) 
    %   overwrites diagonal d, superdiagonal f, left singular vectors U, and
    %   right singular vectors V with the transformation defined in Algorithm
    %   8.6.1 "Golub-Kahan SVD Step", p. 491, in Gene Golub and Charles Van
    %   Loan, Matrix Computations, 4th edition.

    %   Copyright 2022 The MathWorks, Inc.
    %#codegen

    % Reference:
    %    Gene H. Golub and Charles F. Van Loan, Matrix Computations, 4th
    %    ed, Algorithm 8.6.1 "Golub-Kahan SVD Step", p. 491.

    % Normalize the diagonal d and superdiagonal f so you can transform very
    % small elements without underflow.
    [b_normalized, e, e_normalized] = fixed.internal.svd.normalizeMaxOneHalfToOne([d_in f_in]);
    d = setfimath(b_normalized(:,1),fixed.fimathLike(b_normalized));
    f = setfimath(b_normalized(:,2),fixed.fimathLike(b_normalized));

    n = length(d);
    coder.internal.assert(n >= 2,'fixed:linearalgebra:bidiagonalGolubKahanSVDStepSize');
    mu = cast(0,'like',d);
    if n > 2
        mu(:) = fixed.internal.svd.WilkinsonShift(d(n), d(n-1), f(n-1), f(n-2));
    else
        mu(:) = fixed.internal.svd.WilkinsonShift(d(n), d(n-1), f(n-1), cast(0,'like',f));
    end
    [d,f,U,V] = fixed.internal.svd.usv.chaseBulge(d,f,U,V,mu);

    % Renormalize back to the original data type.
    d_out = fixed.internal.svd.normalizeMaxOneHalfToOneInverse(d,e,e_normalized, d_in);
    f_out = fixed.internal.svd.normalizeMaxOneHalfToOneInverse(f,e,e_normalized, f_in);

end
