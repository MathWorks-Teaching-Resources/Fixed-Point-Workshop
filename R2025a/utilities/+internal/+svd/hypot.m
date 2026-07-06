function z = hypot(x,y)
    %hypot Robust computation of the square root of the sum of squares.
    %   z = fixed.internal.svd.hypot(x,y) returns sqrt(abs(x)^2 + abs(y)^2)
    %   carefully computed to avoid overflow and underflow, where x and y are
    %   scalars.
    %
    %   This fixed-point specialization is computed using the CORDIC QR
    %   factorization of the 2-by-1 matrix [x;y].

    %   Copyright 2022 The MathWorks, Inc.
    %#codegen
    z = fixed.qlessQR([x;y]);
end