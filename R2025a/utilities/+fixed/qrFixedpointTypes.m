function T = qrFixedpointTypes(...
        m,...
        max_abs_A,...
        max_abs_B,...
        precisionBits,...
        regularizationParameter,...
        maxWordLength)
%fixed.qrFixedpointTypes QR fixed-point types
%   T = fixed.qrFixedpointTypes(m,max_abs_A,max_abs_B,precisionBits)
%   computes fixed-point types for transforming A to R and B to
%   C=Q'B in-place, where QR is the QR decomposition of A.  It
%   returns struct T with fields T.A and T.B containing fi objects
%   that specify fixed-point types for A and B that guarantee no
%   overflow will occur in the QR algorithm transforming A in-place
%   into upper-triangular R and transforming B in-place into C=Q'B
%   where QR=A is the QR decomposition of A, given the number of
%   rows m of A, max_abs_A is an upper bound on max(abs(A(:))), 
%   max_abs_B is an upper bound on max(abs(B(:))), and
%   precisionBits is the required number of bits of precision.
%
%   T = fixed.qrFixedpointTypes(m,max_abs_A,max_abs_B,precisionBits,regularizationParameter,maxWordLength)
%   computes fixed-point types for transforming
%   [regularizationParameter*eye(n); A] to R and B to
%   C=Q'[zeros(n,size(B,2));B] in-place.
%
%
%   Inputs
%
%        m is the number of rows of A and B.
%    
%        max_abs_A is an upper bound on max(abs(A(:))).
%    
%        max_abs_B is an upper bound on max(abs(B(:))).
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
    narginchk(4,6);
    if nargin < 5
        regularizationParameter = [];
    end
    if isempty(regularizationParameter)
        regularizationParameter = 0;
    end
    if nargin < 6
        maxWordLength = [];
    end
    fixed.internal.validation.validateNumericScalarPositiveInteger(mfilename,m,precisionBits);
    fixed.internal.validation.validateNumericScalarPositive(mfilename,max_abs_A,max_abs_B);

    % regularizationParameter is used for diagonal loading on A, but not B.
    T.A = fixed.qrUpperBoundType(m,max_abs_A,precisionBits,regularizationParameter,maxWordLength);
    T.B = fixed.qrUpperBoundType(m,max_abs_B,precisionBits,[],maxWordLength);
end
