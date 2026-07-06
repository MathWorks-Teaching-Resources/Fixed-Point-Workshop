function y = infnorm(X)
    %infnorm Infinity norm of a matrix.
    %   fixed.internal.svd(X) returns the infinity norm of matrix X specialized
    %   for fixed-point.

    %   Copyright 2022 The MathWorks, Inc.
    %#codegen
    x = sum(abs(X),2);
    y = max(x);
end