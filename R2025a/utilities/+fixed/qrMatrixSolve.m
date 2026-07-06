function X = qrMatrixSolve(A,B,OutputType,regularizationParameter)
%qrMatrixSolve Matrix solve using QR decomposition.
%
%   X = fixed.qrMatrixSolve(A,B) solves matrix equation AX = B
%   using QR decomposition. It is equivalent to X = A\B.
%
%   X = fixed.qrMatrixSolve(A,B,OutputType)  uses OutputType
%   for the type of X.  OutputType can be a numerictype object or a
%   numeric variable such as a fi object.
%
%   X = fixed.qrMatrixSolve(A,B,OutputType,regularizationParameter)
%   solves matrix equation
%   [regularizationParameter*eye(n); A] * X = [zeros(n,p); B]
%   where A is m-by-n and B is n-by-p.  This is called damped
%   least-squares, also known as Tikhonov regularization.  It is
%   equivalent to
%      X = [regularizationParameter*eye(n); A]  \ [zeros(n,p); B]

%   Copyright 2020-2022 The MathWorks, Inc.
%#codegen
    coder.inline('never')
    if nargin<3
        OutputType = cast([],'like',A);
    end
    if nargin<4
        regularizationParameter = cast([],'like',A);
    end
    OutputPrototype = fixed.numerictypeToPrototype(OutputType);
    [C,R] = fixed.qrAB(A,B,regularizationParameter);
    X = fixed.backwardSubstitute(R,C,OutputPrototype);
    X = removefimath(X);
end
