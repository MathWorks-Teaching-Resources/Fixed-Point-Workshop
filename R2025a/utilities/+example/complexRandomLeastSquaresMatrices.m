function [A,B] = complexRandomLeastSquaresMatrices(m,n,p,rankA)
%complexRandomLeastSquaresMatrices Complex random least-squares matrices
%   [A,B] = fixed.example.complexRandomLeastSquaresMatrices(m,n,p,rankA) returns
%   random complex A and B for the least-squares problem A*X = B
%   such that the real and imaginary parts of the elements of A and
%   B are between -1 and 1.
%
%   Inputs
%
%      m is the number of rows in matrices A and B.
%
%      n is the number of columns in matrix A.
%
%      p is the number of columns in matrix B.
%
%      rankA is the rank of matrix A.  If rankA is missing, then rankA=n (the
%      matrix is full rank).

%   Copyright 2021-2022 The MathWorks, Inc.
    if nargin<4
        rankA = n;
    end
    U = fixed.example.complexUniformRandomArray(-1,1,m,rankA);
    V = fixed.example.complexUniformRandomArray(-1,1,n,rankA);
    W = fixed.example.complexUniformRandomArray(-1,1,rankA,p);
    
    A = (U*V');
    B = (U*W);

    % Normalize so the real and imaginary parts of the elements of A and B
    % are between -1 and 1.
    A = A / max(max(abs(real(A)),[],'all'),max(abs(imag(A)),[],'all'));
    B = B / max(max(abs(real(B)),[],'all'),max(abs(imag(B)),[],'all'));
end