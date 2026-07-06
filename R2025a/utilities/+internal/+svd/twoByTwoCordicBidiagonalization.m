function [U,B,V] = twoByTwoCordicBidiagonalization(A)
    %twoByTwoCordicBidiagonalization  Two-by-two CORDIC bidiagonalization.
    %   [U,B,V] = twoByTwoCordicBidiagonalization(A)
    %   factors 2-by-2 matrix A into A = U*B*V' where U and V are orthonormal, and B
    %   is bidiagonal.  Bidiagonal matrix B has the same data type as matrix A.

    %   Copyright 2022 The MathWorks, Inc.
    %#codegen

    % CORDIC constants
    m = int32(0);
    n = int32(0);
    [m(:),n(:)] = size(A);
    assert(m==2 && n==2);
    T = fixed.internal.svd.usv.cordicBidiagonalizationTypes(A);
    [niter, Kn] = fixed.cordicConstants(A);
    B = cast(A,'like',T.B);
    C = eye(m,'like',T.UV);
    V = eye(n,'like',T.UV);
    % Eliminate down
    [B(1,:),B(2,:),C(1,:),C(2,:)] = fixed.qr.cordicgivens(B(1,:),B(2,:),C(1,:),C(2,:),1,niter,Kn);
    % Rotate superdiagonal to real
    if ~isreal(B)
        % Rotate the last superdiagonal to real
        [B(:,n),V(:,n)] = fixed.qr.rotateFirstElementToReal(B(:,n),V(:,n),int32(n-int32(1)),niter,Kn);
        % Rotate the last diagonal element to real
        [B(n,:),C(n,:)] = fixed.qr.rotateFirstElementToReal(B(n,:),C(n,:),int32(n),niter,Kn);
    end
    U = C';
    U = removefimath(U);
    % B becomes real-valued after the bidiagonalization
    B = removefimath(real(B));
    V = removefimath(V);
end
