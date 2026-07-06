function estimated_largest_X = complexQlessQRMatrixSolveUpperBoundX(...
        m,...
        n,...
        max_abs_B,...
        noiseStandardDeviation,...
        p_s,...
        regularizationParameter)
%fixed.complexQlessQRMatrixSolveUpperBoundX Complex matrix solve upper bound for X = (A'A)\B
%   estimated_largest_X = fixed.complexQlessQRMatrixSolveUpperBoundX(m,n,max_abs_B,noiseStandardDeviation,p_s)
%   returns an estimate of the largest value of the matrix
%   solution X = (A'A)\B for complex-valued matrices.
%   
%   estimated_largest_X = fixed.complexQlessQRMatrixSolveUpperBoundX(m,n,max_abs_B,noiseStandardDeviation,p_s,regularizationParameter)
%   returns an estimate of the largest value of the matrix
%   solution X = ([regularizationParameter*eye(n); A]'*[regularizationParameter*eye(n); A])\B for complex-valued matrices.
%   
%   Inputs
%
%        m is the number of rows of A and B.
%    
%        n is the number of columns of A.
%    
%        max_abs_B is an upper bound on max(abs(B(:))).
%    
%        noiseStandardDeviation is the standard deviation of the
%        additive random noise in A.
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

%   Copyright 2021 The MathWorks, Inc.
    narginchk(4,6);
    if nargin < 5
        p_s = [];
    end
    if nargin < 6
        regularizationParameter = [];
    end
    if isempty(p_s)
        p_s = fixed.defaultSingularValueLowerBoundProbability;
    end
    if isempty(regularizationParameter)
        regularizationParameter = 0;
    end
    s_bound = fixed.complexSingularValueLowerBound(m,n,noiseStandardDeviation,p_s,regularizationParameter);
    estimated_largest_X = (double(n)*double(max_abs_B))/(s_bound^2);
end