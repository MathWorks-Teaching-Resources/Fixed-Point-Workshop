function C = realConditionNumberUpperBound(m,n,max_abs_A,noiseStandardDeviation,p_s_n,regularizationParameter)
%fixed.realConditionNumberUpperBound Estimate of an upper bound for the condition number of a real-valued matrix
%   fixed.realConditionNumberUpperBound(m,n,max_abs_A,noiseStandardDeviation)
%   returns an estimate of an upper bound for the 2-norm condition
%   number (the ratio of the largest singular value to the
%   smallest) of an m-by-n matrix A, where max_abs_A >=
%   max(abs(A(:))) and noiseStandardDeviation is the standard
%   deviation of the additive random noise in A.
%
%   fixed.realConditionNumberUpperBound(m,n,max_abs_A,noiseStandardDeviation,p_s_n)
%   also uses p_s_n, the probability of the estimate of the lower
%   bound of the smallest singular value is larger than the actual
%   smallest singular value.
%
%
%   fixed.realConditionNumberUpperBound(m,n,max_abs_A,noiseStandardDeviation,p_s_n,regularizationParameter)
%   returns an estimate of an upper bound for the 2-norm condition
%   number of matrix [regularizationParameter*eye(n); A].
%
%   Inputs
%
%        m is the number of rows of A.
%    
%        n is the number of columns of A.
%    
%        max_abs_A is an upper bound on max(abs(A(:))).
%    
%        noiseStandardDeviation is the standard deviation of the
%        additive random noise in A. If noiseStandardDeviation is
%        not supplied or empty, then the default is the standard deviation
%        of the quantization noise sigma_q = (2^-precisionBits)/(sqrt(12))
%        which is calculated by
%        fixed.realQuantizationNoiseStandardDeviation.
%    
%        p_s_n is the probability that the estimate of the lower bound
%        of the smallest singular value is larger than the actual
%        smallest singular value.  If p_s_n is not supplied or empty, then the
%        default of p_s_n = (1/2)*(1+erf(-5/sqrt(2))) = 2.8665e-07 is
%        used, which is 5 standard deviations below the mean, so the
%        probability that the estimated lower bound for the smallest
%        singular value is less than the actual smallest singular
%        value is 1 - p_s_n = 0.9999997.
%
%        regularizationParameter is the Tikhonov regularization
%        parameter of the matrix
%        [regularizationParameter*eye(n); A].
%        If regularizationParameter is not present or empty, then
%        the default is zero.
%
%   Examples:
%
%     % Low rank with additive noise
%     m = 300;
%     n = 10;
%     rankA = 3;
%     noiseStandardDeviation = sqrt(10^(-50/10));
%     A = fixed.example.realRandomLowRankMatrix(m,n,rankA);
%     A = A + fixed.example.realNormalRandomArray(0,noiseStandardDeviation,m,n);
%     C = fixed.realConditionNumberUpperBound(m,n,max(abs(A(:))),noiseStandardDeviation)
%     C_actual = cond(A)
%  
%     % Low rank with regularization parameter
%     m = 300;
%     n = 10;
%     rankA = 3;
%     regularizationParameter = 0.01;
%     noiseStandardDeviation = sqrt(10^(-50/10));
%     A = fixed.example.realRandomLowRankMatrix(m,n,rankA);
%     A = A + fixed.example.realNormalRandomArray(0,noiseStandardDeviation,m,n);
%     A = [regularizationParameter*eye(n);A];
%     C = fixed.realConditionNumberUpperBound(m,n,max(abs(A(:))),noiseStandardDeviation,[],regularizationParameter)
%     C_actual = cond(A)
%  
%     % Full rank random matrix with normally distributed elements
%     m = 300;
%     n = 10;
%     noiseStandardDeviation = 1;
%     A = fixed.example.realNormalRandomArray(0,noiseStandardDeviation,m,n);
%     C = fixed.realConditionNumberUpperBound(m,n,max(abs(A(:))),noiseStandardDeviation)
%     C_actual = cond(A)
%
%   See also fixed.singularValueUpperBound,
%   fixed.realSingularValueLowerBound, fixed.complexConditionNumberUpperBound.

%   Copyright 2022 The MathWorks, Inc.
%#codegen
    narginchk(4,6);
    if nargin < 5
        p_s_n = [];
    end
    if nargin < 6
        regularizationParameter = [];
    end
    s_1 = fixed.singularValueUpperBound(m,n,max_abs_A,regularizationParameter);
    s_n = fixed.realSingularValueLowerBound(m,n,noiseStandardDeviation,...
        p_s_n,regularizationParameter);
    C = double(s_1)/double(s_n);
    if isnan(C)
        % This is the case when A=zeros(m,n) so that s_1=0 and s2=0.
        % Builtin cond returns inf for cond(zeros(m,n)).
        C = inf;
    elseif C < 1
        % Condition numbers can't be less than one, so protecting from the
        % case where the estimates might be off.  This can happen, for
        % example, when m=300, n=10, max_abs_A=1e-10,
        % regularizationParameter = 1.
        C = 1;
    end
end

