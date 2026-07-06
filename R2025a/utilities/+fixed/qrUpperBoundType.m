function a = qrUpperBoundType(...
        m,...
        maxAbs,...
        precisionBits,...
        regularizationParameter,...
        maxWordLength)
%fixed.qrUpperBoundType Fixed-point type for upper bound of QR.
%   a = fixed.qrUpperBoundType(m,maxAbs,precisionBits) returns fi object
%   a such that no overflow will occur during the QR transformation
%   of a matrix with m rows, maximum absolute value element
%   maxAbs, and precisionBits is the required number of
%   bits of precision.
%
%   a = fixed.qrUpperBoundType(m,maxAbs,precisionBits,regularizationParameter,maxWordLength)
%   returns fi object a such that no overflow will occur during the QR
%   transformation of matrix [regularizationParameter*eye(n); A] where
%   A has m rows and n columns.
%
%
%   Inputs
%
%        m is the number of rows of A or B.
%    
%        maxAbs is an upper bound on max(abs(A(:))) or max(abs(B(:))).
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
    if isempty(regularizationParameter)
        regularizationParameter = 0;
    end
    if nargin < 5
        maxWordLength = [];
    end
    fixed.internal.validation.validateNumericScalarPositiveInteger(mfilename,m,precisionBits);
    fixed.internal.validation.validateNumericScalarPositive(mfilename,maxAbs);
    upperBound = fixed.qrUpperBound(m,maxAbs,regularizationParameter);
    % Account for intermediate CORDIC growth
    a = fixed.internal.type.maxAbsPrecisionToSignedFi(fixed.cordicGrowthFactor*upperBound,precisionBits,maxWordLength);
end