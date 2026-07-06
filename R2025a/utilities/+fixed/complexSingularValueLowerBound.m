function s_n = complexSingularValueLowerBound(m,n,noiseStandardDeviation,p_s_n,...
        regularizationParameter_in)
%fixed.complexSingularValueLowerBound Estimate of a lower bound for the smallest singular value of a complex-valued matrix
%   s_n = fixed.complexSingularValueLowerBound(m,n,noiseStandardDeviation,p_s_n)
%   returns an estimate s_n of a lower bound for the smallest
%   singular value of a complex-valued matrix with m rows and n
%   columns, where m >= n.
%
%   s_n = fixed.complexSingularValueLowerBound(m,n,noiseStandardDeviation,p_s_n,regularizationParameter)
%   returns an estimate s_n of a lower bound for the smallest
%   singular value of a complex-valued matrix
%   [regularizationParameter*eye(n); A] where A has m rows, n
%   columns, and m >= n.
%
%   Inputs 
%
%        m is the number of rows in the matrix.
%
%        n is the number of columns in the matrix.
%
%        noiseStandardDeviation is the standard deviation of the
%        additive random noise in the matrix.
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
%        parameter of the matrix [regularizationParameter*eye(n); A].
%        If regularizationParameter is not present or empty, then
%        the default is zero.

%   Copyright 2021-2022 The MathWorks, Inc.
%#codegen
    narginchk(3,5);
    if nargin < 4
        p_s_n = [];
    end
    if nargin < 5
        regularizationParameter_in = [];
    end
    if isempty(regularizationParameter_in)
        regularizationParameter = 0;
    else
        regularizationParameter = regularizationParameter_in;
    end
    fixed.internal.validation.validateNumericScalarNonnegative(...
        mfilename,noiseStandardDeviation,regularizationParameter);
    s_n = fixed.complexSingularValueLowerBoundiidN01(m,n,p_s_n) * double(noiseStandardDeviation)/sqrt(2);
    % hypot(s_n,double(regularizationParameter)) = 
    % sqrt(s_n^2 + regularizationParameter^2), but computed to avoid overflow
    % and underflow.
    s_n = hypot(s_n,double(regularizationParameter));
end