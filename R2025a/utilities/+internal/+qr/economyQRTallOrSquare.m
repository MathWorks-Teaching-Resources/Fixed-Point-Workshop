function [Q,R] = economyQRTallOrSquare(A)
    %economyQRTallOrSquare Economy-size QR for tall or square input
    %   [Q,R] = fixed.internal.qr.economyQRTallOrSquare(A) computes the
    %   economy-size QR decomposition for tall or square matrix A.

    %   Copyright 2022 The MathWorks, Inc.
    %#codegen
    coder.inline('never')
    T = fixed.internal.svd.usv.cordicBidiagonalizationTypes(A);
    coder.internal.assert(size(A,1)>=size(A,2),'fixed:emblib:MustBeTallAndSkinny','A');
    % Set fimath to floor and wrap in the same type so subscripted
    % assignment will be efficient.
    % Number of rows and columns in A
    m = int32(0);
    n = int32(0);
    [m(:),n(:)] = size(A);
    [niter, Kn] = fixed.cordicConstants(A);
    A = setfimath(A,fixed.fimathLike(A));
    B = eye(m,'like',T.UV);
    % QR algorithm, overwriting A with R and B with Q'.
    for j = 1:n
        for i = j+1:m
            [A(j,:),A(i,:),B(j,:),B(i,:)] = fixed.qr.cordicgivens(A(j,:),A(i,:),B(j,:),B(i,:),j,niter,Kn);
        end
    end
    % Fix up last diagonal element.  It must be real and non-negative.
    if n > 0
        [A(n,:),B(n,:)] = fixed.qr.rotateFirstElementToReal(A(n,:),B(n,:),n,niter,Kn);
        if (real(A(n,n)) < 0)
            % Make last diagonal element non-negative
            A(n,:) = -A(n,:);
            B(n,:) = -B(n,:);
        end
    end
    % Extract the economy-size Q from B and R from A.
    Q = removefimath(B(1:n,:))';
    R = removefimath(A(1:n,1:n));
end
