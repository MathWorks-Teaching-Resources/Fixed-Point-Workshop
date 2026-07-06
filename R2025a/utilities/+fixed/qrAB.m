function [C,R] = qrAB(A,B,regularizationParameter)
    %qrAB Two-input QR decomposition.
    %   [C,R] = fixed.qrAB(A,B) simultaneously performs Givens
    %   rotations to A and B to transform A to R and B to C.  It is
    %   equivalent to
    %      [Q,R] = qr(A,0);
    %      C = Q'*B;
    %
    %   [C,R] = fixed.qrAB(A,B,regularizationParameter) simultaneously
    %   performs Givens rotations to transform
    %   [regularizationParameter*eye(n); A] to R and [zeros(n,p);B] to
    %   C where A is m-by-n and B is m-by-p.  It is equivalent to
    %      [Q,R] = qr([regularizationParameter*eye(n); A],0);
    %      C = Q'*[zeros(n,p); B];

    %   Copyright 2020-2022 The MathWorks, Inc.
    %#codegen
    coder.inline('never')
    [A,B] = fixed.internal.type.upcastWordlength(A,B);
    [m,n] = size(A);
    [~,p] = size(B);
    coder.internal.assert(isequal(size(A,1),size(B,1)),'fixed:emblib:SameNumberOfRows','A','B');
    coder.internal.assert(m>=n,'fixed:emblib:MustBeTallAndSkinny','A');
    C = zeros(n,p,'like',B);
    if nargin>2 && isscalar(regularizationParameter) && ~isequal(real(regularizationParameter),0)
        % R = regularizationParameter * eye(n)
        R = cast(diag(repmat(real(regularizationParameter),1,n)),'like',A);
    else
        R = zeros(n,n,'like',A);
    end
    for i = 1:m
        [C,R] = fixed.qr.qrUpdate(C,R,A(i,:),B(i,:));
    end
end
