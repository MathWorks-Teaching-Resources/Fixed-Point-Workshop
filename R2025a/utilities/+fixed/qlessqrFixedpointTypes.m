function T = qlessqrFixedpointTypes(...
        m,...
        max_abs_A,...
        precisionBits,...
        regularizationParameter,...
        maxWordLength)
%fixed.qlessqrFixedpointTypes Q-less QR fixed-point types
%   T = fixed.qlessqrFixedpointTypes(m,max_abs_A,precisionBits)
%   computes fixed-point types for transforming A to R in-place
%   where R is the upper-triangular factor of the QR decomposition
%   of A, and without computing Q.  It  returns struct T with field
%   T.A containing fi objects that specify the fixed-point type for
%   A that guarantees no overflow will occur in the QR algorithm
%   transforming A in-place into upper-triangular R where QR=A is
%   the QR decomposition of A, given the number of rows m of A,
%   max_abs_A is an upper bound on max(abs(A(:))), and
%   precisionBits is the required number of bits of precision.
%
%   T = fixed.qlessqrFixedpointTypes(m,max_abs_A,precisionBits,regularizationParameter,maxWordLength)
%   computes fixed-point types for transforming
%   [regularizationParameter*eye(n); A] to R in-place where R is the
%   upper-triangular factor of the QR decomposition of
%   [regularizationParameter*eye(n);A], and n is the number of
%   columns of A.
%
%
%   Inputs
%
%        m is the number of rows of A.
%    
%        max_abs_A is an upper bound on max(abs(A(:))).
%    
%        precisionBits is the required number of bits of precision.
%
%        regularizationParameter is the Tikhonov regularization
%        parameter of the least-squares problem
%        [regularizationParameter*eye(n); A]'*[regularizationParameter*eye(n); A]*X = B.
%        If regularizationParameter is not present or empty, then
%        the default is zero.
%
%        maxWordLength is the maximum word length of the fixed-point types.
%        If maxWordLength is not present or empty, then the default is 128.

%   Copyright 2021 The MathWorks, Inc.
    narginchk(3,5);
    if nargin < 4
        regularizationParameter = [];
    end
    if nargin < 5
        maxWordLength = [];
    end
    if isempty(regularizationParameter)
        regularizationParameter = 0;
    end
    T.A = fixed.qrUpperBoundType(m,max_abs_A,precisionBits,regularizationParameter,maxWordLength);
end
