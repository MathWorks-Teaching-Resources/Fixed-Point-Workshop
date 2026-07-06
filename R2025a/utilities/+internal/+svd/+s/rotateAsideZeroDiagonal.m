function [d,f] = rotateAsideZeroDiagonal(d,f,k,q,p)
    %rotateAsideZeroDiagonal Rotate aside zero diagonal of bidiagonal matrix.
    %   [d,f] = fixed.internal.svd.s.rotateAsideZeroDiagonal(d,f,k,q,p) rotates
    %   aside diagonal zero (or nearly zero) element d(k) by applying CORDIC
    %   Givens rotations to the bidiagonal matrix defined by diagonal d and
    %   superdiagonal f.  The bidiagonal matrix has been partitioned into B11,
    %   B22, B33, where B11 is p-by-p, B22 is (n-p-q)-by-(n-p-q), and B33 is
    %   q-by-q.  This function is operating on B22, which has all non-zeros on
    %   its superdiagonal.

    %   Copyright 2022 The MathWorks, Inc.
    %#codegen

    % Reference:
    %    Gene H. Golub and Charles F. Van Loan, Matrix Computations, 4th
    %    ed, Algorithm 8.6.2 "The SVD Algorithm", p 492.

    n = int32(length(d));
    d(k) = 0;
    if k < n-q
        [d,f] = rotateAsideZeroDiagonalLeft(d,f,k,q);
    else % k==n-q
        % if k==n-q, then apply Givens from the
        % right, G(k,j), j=n-q-1:-1:p+1
        [d,f] = rotateAsideZeroDiagonalRight(d,f,q,p);
    end
end

function [d,f] = rotateAsideZeroDiagonalLeft(d,f,k,q)
    n = length(d);
    bulge = f(k);
    f(k)= 0;
    x1 = zeros(1,2,'like',d);
    x2 = zeros(1,2,'like',d);
    for j=k+1:n-q
        x1(1) = d(j);
        x2(1) = bulge;

        x1(2) = f(j);
        x2(2) = 0;

        [niter, Kn] = fixed.cordicConstants(d);
        [x1(:),x2(:)] = fixed.qlessqr.cordicgivens(x1,x2,1,niter,Kn);

        d(j) = x1(1);
        f(j) = x1(2);

        bulge(:) = x2(2);
    end
end


function [d,f] = rotateAsideZeroDiagonalRight(d,f,q,p)
    n = length(d);
    bulge = f(n-q-1);
    f(n-q-1) = 0;
    x1 = zeros(1,2,'like',d);
    x2 = zeros(1,2,'like',d);
    for j=n-q-1:-1:p+1
        x1(1) = d(j);
        x2(1) = bulge;

        if j > p+1
            x1(2) = f(j-1);
        end
        x2(2) = 0;

        [niter, Kn] = fixed.cordicConstants(d);
        [x1(:),x2(:)] = fixed.qlessqr.cordicgivens(x1,x2,1,niter,Kn);

        d(j) = x1(1);

        if j > p+1
            f(j-1) = x1(2);
            bulge(:) = x2(2);
        end

    end
end
