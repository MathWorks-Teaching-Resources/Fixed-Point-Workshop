function [d,f] = chaseBulge(d,f,mu)
    %chaseBulge Chase unwanted nonzero element down the bidiagonal.
    %   [d,f] = fixed.internal.svd.s.chaseBulge(d,f,mu) applies
    %   CORDIC Givens rotations to chase an unwanted nonzero element down a
    %   bidiagonal matrix represented by the diagonal elements d and the
    %   superdiagonal elements f, where mu is the Wilkinson Shift.
    %
    %   The implementation is Step 3 of the SVD Algorithm in Section 8.6.3, on
    %   pages 489 through 491 of Gene H. Golub and Charles F. Van Loan, Matrix
    %   Computations, 4th edition.
    
    %   Copyright 2022 The MathWorks, Inc.
    %#codegen
    n = length(d);
    x  = d(1)^2 - mu;
    y  = d(1) * f(1);
    bulge = cast(0,'like',d);
    for k = 1:n-1
        [d(:),f(:),x(:),y(:),bulge(:)] = chaseBulgeRight(d,f,x,y,bulge,k);
        [d(:),f(:),x(:),y(:),bulge(:)] = chaseBulgeLeft(d,f,x,y,bulge,k);
    end
    f(n) = 0;

end

function [d,f,x,y,bulge] = chaseBulgeRight(d,f,x,y,bulge,k)
    % Input
    x1 = zeros(1,4,'like',d);
    x2 = zeros(1,4,'like',d);

    x1(1) = x;
    x2(1) = y;

    if k>1
        x1(2) = f(k-1);
        x2(2) = bulge;
    end

    x1(3) = d(k);
    x2(3) = f(k);

    % x1(4) = 0
    x2(4) = d(k+1);

    [niter, Kn] = fixed.cordicConstants(d);
    [x1(:),x2(:)] = fixed.qlessqr.cordicgivens(x1,x2,1,niter,Kn);

    % Output
    if k>1
        f(k-1) = x1(2);
    end
    d(k) = x1(3);
    f(k) = x2(3);
    bulge(:) = x1(4);
    d(k+1) = x2(4);

    x = d(k);
    y = bulge;
end

function [d,f,x,y,bulge] = chaseBulgeLeft(d,f,x,y,bulge,k)
    % Input
    x1 = zeros(1,4,'like',d);
    x2 = zeros(1,4,'like',d);

    x1(1) = x;
    x2(1) = y;

    x1(2) = d(k);
    x2(2) = bulge;

    x1(3) = f(k);
    x2(3) = d(k+1);

    % x1(4) = 0;
    x2(4) = f(k+1);


    [niter, Kn] = fixed.cordicConstants(d);
    [x1(:),x2(:)] = fixed.qlessqr.cordicgivens(x1,x2,1,niter,Kn);

    % Output
    d(k) = x1(2);

    f(k) = x1(3);
    d(k+1) = x2(3);

    bulge = x1(4);
    f(k+1) = x2(4);

    x(:) = f(k);
    y(:) = bulge;
end
