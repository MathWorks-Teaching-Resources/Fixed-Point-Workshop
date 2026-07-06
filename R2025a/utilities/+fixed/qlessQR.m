function R = qlessQR(A,forgettingFactor,regularizationParameter)
%qlessQR Q-less QR decomposition.
%   R = fixed.qlessQR(A) computes the economy-size QR decomposition
%   of A without computing Q.  It is equivalent to [~,R] = qr(A,0).
%
%   R = fixed.qlessQR(A,forgettingFactor) updates R with
%   forgettingFactor*R after each row of A is processed.
%   It is the equivalent of computing 
%   [~,R] = qr(forgettingFactor.^(m:-1:1).*A,0).
%
%   R = fixed.qlessQR(A,[],regularizationParameter)
%   transforms [regularizationParameter*eye(n); A] to R.  It is
%   equivalent to [~,R] = qr([regularizationParameter*eye(n); A],0).
%
%   R = fixed.qlessQR(A,forgettingFactor,regularizationParameter)
%   is the equivalent of computing 
%   [~,R] = qr([forgettingFactor^m*regularizationParameter*eye(n); forgettingFactor.^(m:-1:1).*A],0).

%   Copyright 2020-2022 The MathWorks, Inc.
%#codegen
    if nargin < 2
        forgettingFactor = cast([],'like',A);
    end
    coder.inline('never')
    % Number of rows and columns in A
    m = int32(0);
    n = int32(0);
    [m(:),n(:)] = size(A);
    if nargin>2 && isscalar(regularizationParameter) && ~isequal(real(regularizationParameter),0)
        % R = regularizationParameter * eye(n)
        R = cast(diag(repmat(real(regularizationParameter),1,n)),'like',A);
    else
        R = zeros(n,n,'like',A);
    end
    for i = 1:m
        R = fixed.qlessQRUpdate(R,A(i,:),forgettingFactor);
    end
    
end

