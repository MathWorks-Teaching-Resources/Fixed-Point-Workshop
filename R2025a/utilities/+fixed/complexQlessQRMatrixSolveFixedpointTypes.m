function T = complexQlessQRMatrixSolveFixedpointTypes(...
        m,...
        n,...
        max_abs_A,...
        max_abs_B,...
        precisionBits,...
        noiseStandardDeviation,...
        p_s,...
        regularizationParameter,...
        maxWordLength)
%fixed.complexQlessQRMatrixSolveFixedpointTypes Complex Q-less QR matrix solve types
%   T = fixed.complexQlessQRMatrixSolveFixedpointTypes(m,n,max_abs_A,max_abs_B,precisionBits,noiseStandardDeviation,p_s) 
%   computes fixed-point types for matrix solution of complex-valued
%   A'AX=B using QR decomposition.  It returns struct T with fields
%   T.A, T.B, and T.X containing fi objects that specify fixed-point
%   types for A and B that guarantee no overflow will occur in the QR
%   algorithm transforming A in-place into upper-triangular R where
%   QR=A is the QR decomposition of A, and X such that there is a low
%   probability of overflow.
%
%   T = fixed.complexQlessQRMatrixSolveFixedpointTypes(m,n,max_abs_A,max_abs_B,precisionBits,noiseStandardDeviation,p_s,regularizationParameter,maxWordLength) 
%   computes fixed-point types for matrix solution of
%   complex-valued [regularizationParameter*eye(n); A]'*[regularizationParameter*eye(n); A]*X = B.
%
%   Inputs
%
%        m is the number of rows of A and B.
%    
%        n is the number of columns of A.
%    
%        max_abs_A is an upper bound on max(abs(A(:))).
%    
%        max_abs_B is an upper bound on max(abs(B(:))).
%    
%        precisionBits is the required number of bits of precision.
%    
%        noiseStandardDeviation is the standard deviation of the
%        additive random noise in A. If noiseStandardDeviation is
%        not supplied or empty, then the default is the standard deviation
%        of the quantization noise sigma_q = (2^-precisionBits)/(sqrt(6))
%        which is calculated by
%        fixed.complexQuantizationNoiseStandardDeviation.
%    
%        p_s is the probability that the estimate of the lower bound
%        of the smallest singular value is larger than the actual
%        smallest singular value.  If p_s is not supplied or empty, then the
%        default of p_s = (1/2)*(1+erf(-5/sqrt(2))) = 2.8665e-07 is
%        used, which is 5 standard deviations below the mean, so the
%        probability that the estimated lower bound for the smallest
%        singular value is less than the actual smallest singular
%        value is 1 - p_s = 0.9999997.
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
    narginchk(5,9);
    if nargin < 6
        noiseStandardDeviation = [];
    end
    if nargin < 7
        p_s = [];
    end
    if nargin < 8
        regularizationParameter = [];
    end
    if nargin < 9
        maxWordLength = [];
    end

    if isempty(noiseStandardDeviation)
        noiseStandardDeviation = fixed.complexQuantizationNoiseStandardDeviation(precisionBits);
    end
    if isempty(p_s)
        p_s = fixed.defaultSingularValueLowerBoundProbability;
    end
    if isempty(regularizationParameter)
        regularizationParameter = 0;
    end
    
    estimated_largest_X = fixed.complexQlessQRMatrixSolveUpperBoundX(m,n,...
        max_abs_B,noiseStandardDeviation,p_s,regularizationParameter);
    
    T = fixed.qlessqrFixedpointTypes(m,max_abs_A,precisionBits,regularizationParameter,maxWordLength);
    % No growth in b is needed because it is not transformed.
    T.B = fixed.internal.type.maxAbsPrecisionToSignedFi(max_abs_B, precisionBits, maxWordLength);
    % Account for intermediate CORDIC growth
    T.X = fixed.internal.type.maxAbsPrecisionToSignedFi(fixed.cordicGrowthFactor*estimated_largest_X,precisionBits,maxWordLength);
end
