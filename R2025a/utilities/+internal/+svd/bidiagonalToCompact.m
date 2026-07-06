 function b = bidiagonalToCompact(B)
    %bidiagonalToCompact Bidiagonal matrix to compact bidiagonal matrix.
    %   b = fixed.internal.svd.bidiagonalToCompact(B) returns the diagonal of B
    %   in the first column of b, and the superdiagonal of B in the second
    %   column of b.

    %   Copyright 2022 The MathWorks, Inc.
    %#codegen
    n = size(B,2);
    b = zeros(n,2,'like',B);
    if n == 1
        b(1,1) = B(1);
    elseif n > 1
        b(:,1) = diag(B);
        b(:,2) = [diag(B,1);0];
    end
end
