function [p,q] = partitionBidiagonalMatrix(b, tol)
    %partitionBidiagonalMatrix Partition bidiagonal matrix.
    %   [p,q] = fixed.internal.svd.partitionBidiagonalMatrix(b,tol) partitions
    %   compact bidiagonal matrix b into three sub-matrices, B11, B22, B33
    %   where B33 is diagonal and B22 has all non-zeros on its superdiagonal.
    %   B11 is p-by-p, B22 is (n-p-q)-by-(n-p-q), and B33 is q-by-q.
    %   Sub-matrix B22 is used by bidiagonalSVD after rotating out any zeros on
    %   its diagonal.
    %
    %   Compact bidiagonal matrix b has the diagonal as its first column and
    %   the superdiagonal as its second column.

    %   Copyright 2022 The MathWorks, Inc.
    %#codegen

    % Reference:
    %    Gene H. Golub and Charles F. Van Loan, Matrix Computations, 4th
    %    ed, Algorithm 8.6.2 "The SVD Algorithm", p. 492.
    d = b(:,1);
    f = b(:,2);

    n = int32(length(d));
    q = int32(0);
    p = int32(n-1);
    for k = n-1:-1:1
        % Equation on the bottom of p. 491, Golub & Van Loan, 4th ed.
        threshold = tol*(abs(d(k)) + abs(d(k+1)));
        if abs(f(k)) <= threshold
            % Find the boundary of B33, which has all zero superdiagonal.
            f(k) = 0;
            if q == n-k-1
                q = n-k;
                p = k-1;
            end
        else
            % Find the boundary of B11, which has at least one zero on the
            % super diagonal.  B22 will be in the middle, with all non-zero
            % on the superdiagonal.
            if p == k
                p = k-1;
            end
        end
    end
end
