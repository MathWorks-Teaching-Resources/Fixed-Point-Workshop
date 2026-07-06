function mu = WilkinsonShift(dn,dn1,fn1,fn2)
    %WilkinsonShift Wilkinson Shift.
    %   fixed.internal.svd.WilkinsonShift(dn,dn1,fn1,fn2) returns the
    %   Wilkinson Shift used in the Implicit Symmetric QR Step, where
    %   dn=d(n), dn1=d(n-1), fn1=f(n-1), fn2=f(n-2), and d is the diagonal and
    %   f is the superdiagonal of the bidiagonal matrix.

    %   Copyright 2022 The MathWorks, Inc.
    %#codegen

    % Golub & Van Loan 4th ed, pp. 461--463, Implicit Symmetric QR Step
    % with Wilkinson Shift

    % Reference:
    %    Gene H. Golub and Charles F. Van Loan, Matrix Computations, 4th ed,
    %    Algorithm 8.3.2 Implicit Symmetric QR Step with Wilkinson Shift, pp.
    %    461--463.

    % The convergence is roughly cubic using the Wilkinson shift.
    a1 = dn1^2+fn2^2;
    b1 = dn1*fn1;
    a2 = dn^2+fn1^2;

    a1 = setfimath(a1,fixed.fimathLike(a1));
    b1 = setfimath(b1,fixed.fimathLike(a1));
    a2 = setfimath(a2,fixed.fimathLike(a1));
    mu = cast(0,'like',a1);
    discriminant = bitsra( a1 - a2, 1);
    if discriminant == 0
        if a2 > 0
            mu(:) = a2 + abs( b1 );
        else
            mu(:) = a2 - abs( b1 );
        end
    else
        if discriminant < 0
            den = discriminant - fixed.internal.svd.hypot(discriminant,b1);
        else
            den = discriminant + fixed.internal.svd.hypot(discriminant,b1);
        end
        [c,e] = fixed.normalizedDivide(b1, den);
        mu(:) = a2 - fixed.bitshift(b1*removefimath(c),e);
    end

    mu = removefimath(mu);
end
