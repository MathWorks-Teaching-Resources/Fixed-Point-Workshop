function [U,S,V] = svdSquareOrTallSkinny(A, econFlag, matrixFlag)
    %svdSquareOrTallSkinny Singular value decomposition of square or tall and skinny matrices.
    %   [U,S,V] = fixed.internal.svd.usv.svdSquareOrTallSkinny(A, econFlag, matrixFlag)
    %   computes the singular value decomposition of matrix A where the number
    %   of rows of A is greater than or equal to the number of columns of A.
    %
    %   If econFlag is true, then only the first n columns of U are returned.
    %
    %   If matrixFlag is true, then the singular values s are return in a
    %   diagonal matrix S.

    %   Copyright 2022 The MathWorks, Inc.
    %#codegen

    [m,n] = size(A);
    coder.internal.assert(ismatrix(A),'fixed:linearalgebra:inputMustBeMatrix');
    coder.internal.assert(m>=n,'fixed:linearalgebra:rowsGEcolumns');
    [U,B,V] = fixed.internal.svd.usv.cordicBidiagonalization(A,econFlag);
    if isempty(A)
        s = B;
    else
        didConverge = false;
        % Make the bidiagonal matrix b into compact form, where the first
        % column of B1 is the main diagonal, and the second column of B1 is the
        % first superdiagonal appended with a zero to make it the right size.
        b = fixed.internal.svd.bidiagonalToCompact(B);
        if n > 1
            % Normalize the bidiagonal to control fixed-point growth.
            [b_normalized, e, e_normalized] = fixed.internal.svd.normalizeMaxOneHalfToOne(b);
            % Compute diagonal d and update U, V such that U*diag(d)*V' = A
            d_normalized = b_normalized(:,1);
            f_normalized = b_normalized(:,2);
            while ~didConverge
                [d_normalized(:), f_normalized(:), U(:), V(:), didConverge] = fixed.internal.svd.usv.bidiagonalSVD(d_normalized, f_normalized, U, V);
                % If it did not converge, zero the smallest magnitude
                % off-diagonal element and try again.  This will always end
                % because in the worst case all off-diagonal elements will
                % be set to zero after a maximum of n-1 iterations.
                f_normalized(:) = fixed.internal.svd.zeroSmallestMagnitudeElement(f_normalized);
            end
            s_upcast = fixed.internal.svd.normalizeMaxOneHalfToOneInverse(d_normalized,e,e_normalized, A);
            s = cast(s_upcast,'like',real(A));
        else
            % n == 1
            s = b(1);
        end
    end
    [U,S,V] = fixed.internal.svd.usv.resizeSVD(m,n,U,s,V,econFlag,matrixFlag);
end

