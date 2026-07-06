function [d,V] = rectifySingularValues(d,V)
    %rectifySingularValues  Rectify singular values. 
    %   [d,V] = fixed.internal.svd.rectifySingularValues(d,V) makes the
    %   elements of diagonal d nonnegative, and applies the same transformation
    %   to the columns of V.
    %
    %   During the computation of the singular value decomposition, the
    %   diagonal elements of the bidiagonal matrix may be negative.  This
    %   function rectifies the elements of d to become positive singular
    %   values.

    %   Copyright 2022 The MathWorks, Inc.
    %#codegen
    % Make all singular values positive.  Adjust the corresponding elements
    % of V with the same sign change.
    n = size( V, 1 );
    for k = 1:n
        if d(k) < 0
            d(k)    = -d(k);
            V(:,k)  = -V(:,k);
        end
    end
end