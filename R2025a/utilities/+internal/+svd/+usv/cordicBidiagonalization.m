function [U,B,V] = cordicBidiagonalization(A,econFlag)
    %cordicBidiagonalization  CORDIC bidiagonalization.
    %   [U,B,V] = fixed.internal.svd.usv.cordicBidiagonalization(A,econFlag)
    %   factors matrix A into A = U*B*V' where U and V are orthonormal, and B
    %   is bidiagonal.  Bidiagonal matrix B has the same data type as matrix A.
    %
    %   If econFlag is true, then only the first n columns of U are returned,
    %   where n is the number of columns of A.

    %   Copyright 2022 The MathWorks, Inc.
    %#codegen

    % CORDIC constants
    [m,n] = size(A);
    coder.internal.assert(m>=n,'fixed:emblib:MustBeTallAndSkinny','A');
    if econFlag
        [U,B,V] = economyBidiagonalization(A);
    else
        [U,B,V] = fullBidiagonalization(A);
    end
    U = removefimath(U);
    % B becomes real-valued after the bidiagonalization
    B = removefimath(real(B));
    V = removefimath(V);
end

function [U,B,V] = economyBidiagonalization(A)
    n = size(A,2);
    T = fixed.internal.svd.usv.cordicBidiagonalizationTypes(A);
    % Reduce to upper-triangular first with QR, then work on the economy
    % size U and B.
    [Q,R] = fixed.internal.qr.economyQRTallOrSquare(A);
    C = cast(Q','like',T.UV);
    B = cast(R,'like',T.B);
    V = eye(n,'like',T.UV);
    [C,B,V] = triangularToBidiagonal(C,B,V);
    U = C';
end

function [C,B,V] = triangularToBidiagonal(C,B,V)
    [niter, Kn] = fixed.cordicConstants(B);
    n = int32(size(B,2));
    for i = 1:n-2
        for j = n:-1:(i+2)
            % Eliminate the i,j superdiagonal element.
            [B(:,j-1),B(:,j),V(:,j-1),V(:,j)] = fixed.qr.cordicgivens(B(:,j-1),B(:,j),V(:,j-1),V(:,j),i,niter,Kn);

            % Eliminate the non-zero subdiagonal element that was
            % introduced when zeroing the i,j superdiagonal element.
            [B(j-1,:),B(j,:),C(j-1,:),C(j,:)] = fixed.qr.cordicgivens(B(j-1,:),B(j,:),C(j-1,:),C(j,:),j-1,niter,Kn);
        end
    end
    [C,B,V] = rotateLastSuperdiagonal(C,B,V,n,niter,Kn);
end

function [U,B,V] = fullBidiagonalization(A)
    [m,n] = size(A);
    T = fixed.internal.svd.usv.cordicBidiagonalizationTypes(A);
    [niter, Kn] = fixed.cordicConstants(A);
    B = cast(A,'like',T.B);
    C = eye(m,'like',T.UV);
    V = eye(n,'like',T.UV);
    for j = 1:int32(n)
        [C,B] = eliminateDown(C,B,j,m,niter,Kn);
        [B,V] = eliminateAcross(B,V,j,n,niter,Kn);
    end
    [C,B,V] = rotateLastSuperdiagonal(C,B,V,n,niter,Kn);
    U = C';
end

function [C,B] = eliminateDown(C,B,j,m,niter,Kn)
    % Introduce zeros below the diagonal in the j-th column.
    % Operate on the rows of B and the columns of U.
    % The conjugate of U is computed, so B = U'*A*V, i.e. U*B*V' = A as
    % desired.

    for i = j+1:m
        % Perform Givens rotations to zero out the B(i,j) element of B.
        [B(j,:),B(i,:),C(j,:),C(i,:)] = fixed.qr.cordicgivens(B(j,:),B(i,:),C(j,:),C(i,:),j,niter,Kn);
    end
end


function [B,V] = eliminateAcross(B,V,j,n,niter,Kn)
    % Introduce zeros to the right of the superdiagonal in the j-th row.
    % Operate on the columns of B and the columns of V.
    if j <= n-2
        for k = j+2:n
            % Perform Givens rotations to zero out the B(j,k) element of B.
            [B(:,j+1),B(:,k),V(:,j+1),V(:,k)] = fixed.qr.cordicgivens(B(:,j+1),B(:,k),V(:,j+1),V(:,k),j,niter,Kn);
        end
    end
end

function [C,B,V] = rotateLastSuperdiagonal(C,B,V,n,niter,Kn)
    if ~isreal(B) && n > 1
        % Rotate the last superdiagonal to real
        [B(:,n),V(:,n)] = fixed.qr.rotateFirstElementToReal(B(:,n),V(:,n),n-1,niter,Kn);
        % Rotate the last diagonal element to real
        [B(n,:),C(n,:)] = fixed.qr.rotateFirstElementToReal(B(n,:),C(n,:),n,niter,Kn);
    end
end