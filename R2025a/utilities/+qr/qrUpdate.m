function [C,R] = qrUpdate(C,R,y,v)
%qrUpdate  QR update.
%   [C,R] = qrUpdate(C,R,y,v) updates upper-triangular R with
%   vector y using CORDIC Givens rotations.  It is equivalent to
%      [~,R] = qr([R;y],0);
%   The same rotations are applied to [C;v].

%   Copyright 2020-2022 The MathWorks, Inc.
%#codegen

    % CORDIC constants
    [niter, Kn] = fixed.cordicConstants(y);
    % Number of rows and columns in R
    n = int32(size(R,1));
    for j = 1:n
        [R(j,:),y(:),C(j,:),v(:)] = fixed.qr.cordicgivens(R(j,:),y,C(j,:),v,j,niter,Kn);
    end
end
