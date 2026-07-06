function [u,s,v] = twoByTwoOrthogonalDiagonalDecomposition(a)
    %twoByTwoOrthogonalDiagonalDecomposition

    %   Copyright 2022 The MathWorks, Inc.
    %#codegen

    % Compute the vector 2-by-2 svd without rectifying or sorting.
    coder.inline('never')
    [m,n] = size(a);
    assert(m==2 && n==2)
    % s = u'*a*v
    if isreal(a)
        T = fixed.internal.svd.usv.cordicBidiagonalizationTypes(a);
        u = eye(2,'like',T.UV);
        v = eye(2,'like',T.UV);
        B = a;
    else
        % Make B real
        % A = U*B*V', and B is real and upper bidiagonal.
        [u,B,v] = fixed.internal.svd.twoByTwoCordicBidiagonalization(a);
    end
    if ~isequal(diag(diag(B)),B)
        [J,K] = fixed.internal.svd.twoByTwoRealJacobiRotationMatrices(B);
        B(:) = J'*setfimath(B,fixed.fimathLike(B));
        B(:) = setfimath(B,fixed.fimathLike(B))*K;
        u(:) = setfimath(u,fixed.fimathLike(u))*J;
        v(:) = setfimath(v,fixed.fimathLike(v))*K;
    end
    s = real(diag(B));

    % We don't need to rectify and sort for Jacobi SVD to work.
end