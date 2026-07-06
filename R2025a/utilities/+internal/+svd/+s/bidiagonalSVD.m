function [d, f, didConverge] = bidiagonalSVD(d, f)
    %bidiagonalSVD Bidiagonal singular value decomposition.
    %   [d, f, didConverge] = fixed.internal.svd.s.bidiagonalSVD(d, f)
    %   computes the singular value decomposition on the bidiagonal matrix
    %   defined by diagonal d and superdiagonal f.

    %   Copyright 2022 The MathWorks, Inc.
    %#codegen

    % Reference:
    %    Gene H. Golub and Charles F. Van Loan, Matrix Computations, 4th
    %    ed, Algorithm 8.6.2 "The SVD Algorithm", p 492.

    n = int32(length(d));   % Number of columns
    tol = coder.const(fixed.internal.svd.svdTolerance(d));
    maxiter = coder.const(fixed.internal.svd.svdMaximumNumberOfIterations(n));

    d = setfimath(d,fixed.fimathLike(d));
    f = setfimath(f,fixed.fimathLike(f));
    iter = cast(0,'like',maxiter);
    q = int32(0);
    didConverge = true;
    while q < n
        iter(:) = iter + 1;
        if iter >= maxiter
            didConverge = false;
            break
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
                [d,f] = fixed.internal.svd.s.rotateAsideZeroDiagonal(d,f,k,q,p);
            else
                % No element on the diagonal is zero of B22
                % GK SVD step for the B22 submatrix.
                [d(p+1:n-q,:), f(p+1:n-q,:)] = ...
                    fixed.internal.svd.s.bidiagonalGolubKahanSVDStep(d(p+1:n-q,:), f(p+1:n-q,:));
            end
        end % if q
    end % while q<n
    d = abs(d);
    d = removefimath(d);

end


