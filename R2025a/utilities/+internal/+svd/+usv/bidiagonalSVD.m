function [d, f, U, V, didConverge] = bidiagonalSVD(d, f, U, V)
    %bidiagonalSVD Bidiagonal singular value decomposition.
    %   [d, f, U, V, didConverge] = fixed.internal.svd.usv.bidiagonalSVD(d, f, U, V)
    %   computes the singular value decomposition on the bidiagonal matrix
    %   defined by diagonal d and superdiagonal f and applies the same
    %   transformations to the left singular vectors U and right singular
    %   vectors V.

    %   Copyright 2022 The MathWorks, Inc.
    %#codegen

    % Reference:
    %    Gene H. Golub and Charles F. Van Loan, Matrix Computations, 4th
    %    ed, Algorithm 8.6.2 "The SVD Algorithm", p 492.

    n = int32(size(V,1));   % Number of columns
    tol = coder.const(fixed.internal.svd.svdTolerance(d));
    maxiter = coder.const(fixed.internal.svd.svdMaximumNumberOfIterations(n));

    d = setfimath(d,fixed.fimathLike(d));
    f = setfimath(f,fixed.fimathLike(f));
    U = setfimath(U,fixed.fimathLike(U));
    V = setfimath(V,fixed.fimathLike(V));

    iter = cast(0,'like',maxiter);

    q = int32(0);
    didConverge = true;
    while q < n
        iter(:) = iter + 1;
        if iter >= maxiter
            didConverge = false;
            break;
        end

        [p,q] = fixed.internal.svd.partitionBidiagonalMatrix([d f],tol);

        if q == n-1
            % The diagonalization complete.  The while loop will
            % now exit
            q=n;
        else
            % If any element on the diagonal of B22 is zero, then rotate it
            % aside.
            k = p+1;
            % Equation on the bottom of p. 491, Golub & Van Loan, 4th ed.
            smalldiag = tol * fixed.internal.svd.infnorm([d f]);
            while abs( d(k) ) > smalldiag  && k < n-q
                k = k+1;
            end
            if abs( d(k) ) <= smalldiag
                % There is a zero on the diagonal, so zero out the
                % superdiagonal element in the same row.
                [d,f,U,V] = fixed.internal.svd.usv.rotateAsideZeroDiagonal(d,f,U,V,k,q,p);
            else
                % No element on the diagonal is zero of B22
                % GK SVD step for the B22 submatrix.
                [d(p+1:n-q,:), f(p+1:n-q,:), U(:,p+1:n-q), V(:,p+1:n-q)] = ...
                    fixed.internal.svd.usv.bidiagonalGolubKahanSVDStep(d(p+1:n-q,:), f(p+1:n-q,:), U(:,p+1:n-q), V(:,p+1:n-q));
            end
        end % if q
    end % while q<n
    [d,V] = fixed.internal.svd.usv.rectifySingularValues(d,V);
    d = removefimath(d);
    U = removefimath(U);
    V = removefimath(V);
end


