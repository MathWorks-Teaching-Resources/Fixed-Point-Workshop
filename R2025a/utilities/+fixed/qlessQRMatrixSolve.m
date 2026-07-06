function X = qlessQRMatrixSolve(A,B,OutputType,forgettingFactor,regularizationParameter)
%qlessQRMatrixSolve Q-less QR matrix solve.
%   X = fixed.qlessQRMatrixSolve(A,B) Solves the matrix equation
%   (A'*A)*X = B.
%
%   X = fixed.qlessQRMatrixSolve(A,B,OutputType) uses OutputType
%   for the type of X.  OutputType can be a numerictype object or a
%   numeric variable such as a fi object.
%
%   X = fixed.qlessQRMatrixSolve(A,B,OutputType,forgettingFactor)
%   updates upper-triangular factor R of A with forgettingFactor*R
%   after each row of A is processed.
%
%   X = fixed.qlessQRMatrixSolve(A,B,OutputType,[],regularizationParameter)
%   solves matrix equation
%      (lambda^2*eye(n) + A'A)x = B.
%
%   X = fixed.qlessQRMatrixSolve(A,B,OutputType,forgettingFactor,regularizationParameter)
%   initializes upper-triangular factor R of A with lambda*eye(n)
%   and updates with forgettingFactor*R after each row of A is processed.
%
%   Algorithm:
%   X = fixed.qlessQRMatrixSolve(A,B) is equivalent to
%   [~,R] = qr(A,0)
%   X = R\(R'\B) = (A'*A)\B

%   Copyright 2020-2021 The MathWorks, Inc.
%#codegen
    coder.inline('never')
    if nargin<3
        OutputType = cast([],'like',A);
    end
    if nargin<4
        forgettingFactor = cast([],'like',A);
    end
    if nargin<5
        regularizationParameter = cast([],'like',A);
    end
    OutputPrototype = fixed.numerictypeToPrototype(OutputType);
    R = fixed.qlessQR(A,forgettingFactor,regularizationParameter);
    % R'\B
    X = fixed.forwardSubstitute(R,B,OutputPrototype);
    % R\(R'B)
    X(:) = fixed.backwardSubstitute(R,X,OutputPrototype);
    X = removefimath(X);
end
