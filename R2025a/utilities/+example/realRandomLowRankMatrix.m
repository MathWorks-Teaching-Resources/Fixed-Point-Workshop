function A = realRandomLowRankMatrix(m,n,rankA)
%realRandomLowRankMatrix Real random low rank matrix
%   A = fixed.example.realRandomLowRankMatrix(m,n,rankA) returns uniformly
%   distributed random real matrix A such that the elements of A are
%   between -1 and 1.
%
%   Inputs
%
%      m is the number of rows in matrices A and B.
%
%      n is the number of columns in matrix A.
%
%      rankA is the rank of matrix A.  If rankA is missing, then rankA=n (the
%      matrix is full rank).

%   Copyright 2021-2022 The MathWorks, Inc.
    if nargin < 3
        rankA = n;
    end
    U = fixed.example.realUniformRandomArray(-1,1,m,rankA);
    V = fixed.example.realUniformRandomArray(-1,1,n,rankA);
    
    A = (U*V');
    % Normalize so the elements of A are between -1 and 1.
    A = A / max(abs(A),[],'all');
end