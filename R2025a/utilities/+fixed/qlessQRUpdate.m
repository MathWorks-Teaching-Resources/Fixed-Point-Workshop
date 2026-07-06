function R = qlessQRUpdate(R,y,forgettingFactor)
%qlessQRUpdate Q-less QR update.
%   R = fixed.qlessQRUpdate(R,y) updates upper-triangular R with
%   vector y.  It is equivalent to 
%      [~,R] = qr([R;y],0);
%
%   R = fixed.qlessQRUpdate(R,y,forgettingFactor) updates
%   upper-triangular R with vector y, then multiplies by
%   forgettingFactor.  It is equivalent to 
%      [~,R] = qr([R;y],0);
%      R(:) = forgettingFactor * R;

%   Copyright 2020-2022 The MathWorks, Inc.
%#codegen
    coder.inline('never')
    % CORDIC constants
    [niter, Kn] = fixed.cordicConstants(y);
    % Number of rows and columns in R
    n = int32(size(R,1));
    for j = 1:n
        [R(j,:),y(:)] = fixed.qlessqr.cordicgivens(R(j,:),y,j,niter,Kn);
    end
    if nargin>=3 && isscalar(forgettingFactor) && forgettingFactor~=0 && forgettingFactor~=1
        % Compute the multiplication in R's type because forgettingFactor is
        % less than one.
        R(:) = setfimath(forgettingFactor,fixed.fimathLike(R)) * removefimath(R);
    end
end
