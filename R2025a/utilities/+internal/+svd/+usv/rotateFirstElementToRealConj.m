function [x,u] = rotateFirstElementToRealConj(x,u,j,niter,Kn)
    %rotateFirstElementToRealConj Rotate the first element to real and conjugate.
    %   [x,u] = fixed.internal.svd.usv.rotateFirstElementToRealConj(x,u,j,niter,Kn) 
    %   applies CORDIC Givens transformation to rotate x(j)
    %   to be real valued, and applies the conjugate transformation to u, where
    %   niter is the number of CORDIC iterations and Kn is the inverse of the
    %   CORDIC gain factor.
    %
    %   This function is used in
    %   fixed.internal.svd.usv.cordicBidiagonalization.

    %   Copyright 2022 The MathWorks, Inc.
    %#codegen

    % rotateFirstElementToRealConj is equivalent to the following, but
    % rotateFirstElementToRealConj is more efficient.
    % [x(j,:),U(:,j)] = fixed.qr.rotateFirstElementToReal(x(j,:),conj(U(:,j)),j,niter,Kn);
    % U(:,j) = conj(U(:,j));

    if ~isreal(x) && imag(x(j))~=0
        % Rotate x so that imag(x(j)) = 0, if its not already 0.
        % Reverse the real and imaginary part of u to compute the conjugate.
        [xr,xi,ui,ur] = fixed.qr.cordicgivens(real(x),imag(x),imag(u),real(u),j,niter,Kn);
        x(:) = complex(xr,xi);
        u(:) = complex(ur,ui);
    end
end