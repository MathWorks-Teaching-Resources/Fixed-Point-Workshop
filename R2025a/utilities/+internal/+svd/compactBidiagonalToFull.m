function B = compactBidiagonalToFull(b)
    %compactBidiagonalToFull Compact bidiagonal matrix to full bidiagonal matrix.
    %    B = fixed.internal.svd.compactBidiagonalToFull(b) returns bidiagonal
    %    matrix B whose diagonal is the first column of b, and whose
    %    superdiagonal is the second column of b.

    %   Copyright 2022 The MathWorks, Inc.
    %#codegen
    n = size(b,1);
    B = zeros(n,n,'like',b);
    for i = 1:n
        B(i,i) = b(i,1);
    end
    for i = 1:n-1
        B(i,i+1) = b(i,2);
    end
end
