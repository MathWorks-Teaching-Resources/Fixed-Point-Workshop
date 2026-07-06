function [A,B] = realRandomQlessQRMatrices(m,n,p,rankA)
%realRandomQlessQRMatrices Real random Q-less QR matrices
%   [A,B] = fixed.example.realRandomQlessQRMatrices(m,n,p,rankA) returns
%   random real A and B for the matrix problem (A'*A)*X = B
%   such that the elements of A and B are between -1 and 1.
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
    if nargin < 4
        rankA = n;
    end
    U = fixed.example.realUniformRandomArray(-1,1,m,rankA);
    V = fixed.example.realUniformRandomArray(-1,1,n,rankA);
    A = (U*V');
    % Normalize so the elements of A are between -1 and 1.
    A = A / max(abs(A),[],'all');

    B = fixed.example.realUniformRandomArray(-1,1,n,p);
end