function x_out = rotateFirstElementToReal(x,j,niter,Kn)
    %rotateFirstElementToReal Rotate first element to real.
    %   x = rotateFirstElementToReal(x,j,niter,Kn) rotates complex x(j)
    %   to real so that imag(x(j))==0 and real(x(j))=abs(x(j)) using
    %   CORDIC Givens rotations and applies the same rotation to the
    %   rest of vector x.

    %   Copyright 2020-2022 The MathWorks, Inc.
    %#codegen

    if isreal(x)
        x_out = x;
    else
        % Rotate x so that imag(x(j)) = 0, if its not already 0.
        [xr,xi] = fixed.qlessqr.cordicgivens(real(x),imag(x),j,niter,Kn);
        x_out = complex(xr,xi);
    end
end