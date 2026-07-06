function [y_out,v_out] = rotateFirstElementToReal(y,v,j,niter,Kn)
%rotateFirstElementToReal Rotate first element to real.
%   [y,v] = rotateFirstElementToReal(y,v,j,niter,Kn) rotates
%   complex y(j) to real so that imag(y(j))==0 and
%   real(y(j))=abs(y(j)) using CORDIC Givens rotations and applies
%   the same rotation to the rest of vector y, and to vector v.

%   Copyright 2020-2022 The MathWorks, Inc.
%#codegen
    if isreal(y)
        y_out = y;
        v_out = v;
    else
        % Rotate y so that imag(y(j)) = 0, if its not already 0.
        [yr,yi,vr,vi] = fixed.qr.cordicgivens(real(y),imag(y),real(v),imag(v),j,niter,Kn);
        y_out = complex(yr,yi);
        v_out = complex(vr,vi);
    end
end