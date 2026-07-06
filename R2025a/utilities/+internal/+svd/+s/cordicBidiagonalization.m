function B = cordicBidiagonalization(A)
    %cordicBidiagonalization  CORDIC bidiagonalization.
    %   B = fixed.internal.svd.s.cordicBidiagonalization(A)
    %   factors matrix A into A = U*B*V' where U and V are orthonormal, and B
    %   is bidiagonal.  Bidiagonal matrix B has the same data type as matrix A.

    %   Copyright 2022 The MathWorks, Inc.
    %#codegen

    % CORDIC constants
     T = fixed.internal.svd.s.cordicBidiagonalizationTypes(A);
    [niter, Kn] = fixed.cordicConstants(A);
    [m,n] = size(A);
    coder.internal.assert(m>=n,'fixed:emblib:MustBeTallAndSkinny','A');
    B = cast(A,'like',T.B);
    for j = 1:int32(n)
        B = eliminateDown(B,j,m,niter,Kn);
        B = eliminateAcross(B,j,n,niter,Kn);
    end
    B = rotateLastSuperdiagonal(B,n,niter,Kn);
    % B becomes real after the full bidiagonalization
    B = removefimath(real(B));
end

function B = eliminateDown(B,j,m,niter,Kn)
    % Introduce zeros below the diagonal in the j-th column.
    % Operate on the rows of B.
    for i = j+1:m
        % Perform Givens rotations to zero out the B(i,j) element of B.
        [B(j,:),B(i,:)] = fixed.qlessqr.cordicgivens(B(j,:),B(i,:),j,niter,Kn);
    end
end

function B = eliminateAcross(B,j,n,niter,Kn)
    % Introduce zeros to the right of the superdiagonal in the j-th row.
    % Operate on the columns of B.
    if j <= n-2
        for k = j+2:n
            % Perform Givens rotations to zero out the B(j,k) element of B.
            [B(:,j+1),B(:,k)] = fixed.qlessqr.cordicgivens(B(:,j+1),B(:,k),j,niter,Kn);
        end
    end
end

function B = rotateLastSuperdiagonal(B,n,niter,Kn)
    if ~isreal(B) && n > 1
        % Rotate the last superdiagonal to real
        B(:,n) = fixed.qlessqr.rotateFirstElementToReal(B(:,n),n-1,niter,Kn);
        % Rotate the last diagonal element to real
        B(n,:) = fixed.qlessqr.rotateFirstElementToReal(B(n,:),n,niter,Kn);
    end
end