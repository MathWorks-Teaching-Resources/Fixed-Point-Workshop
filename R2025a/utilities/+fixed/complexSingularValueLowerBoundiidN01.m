function s_n = complexSingularValueLowerBoundiidN01(m,n,p_s_n_in)
%fixed.complexSingularValueLowerBoundiidN01 Estimate of a lower bound for the smallest singular value of a complex-valued random matrix
%   s_n = fixed.complexSingularValueLowerBoundiidN01(m,n,p_s_n)
%   returns an estimate s_n of a lower bound for the smallest
%   singular value of a complex-valued matrix with m rows and n
%   columns, where m >= n, and whose real and imaginary elements are
%   independent identically distributed (iid) normal random
%   variables with mean 0 and standard deviation 1.
%
%   Inputs 
%
%        m is the number of rows in the matrix.
%
%        n is the number of columns in the matrix.
%
%        p_s_n is the probability that the estimate of the lower bound
%        of the smallest singular value is larger than the actual
%        smallest singular value.  If p_s_n is not supplied or empty, then the
%        default of p_s_n = (1/2)*(1+erf(-5/sqrt(2))) = 2.8665e-07 is
%        used, which is 5 standard deviations below the mean, so the
%        probability that the estimated lower bound for the smallest
%        singular value is less than the actual smallest singular
%        value is 1 - p_s_n = 0.9999997.

%   Copyright 2021-2022 The MathWorks, Inc.
%#codegen
    narginchk(2,3);
    if nargin < 3
        p_s_n_in = [];
    end
    if isempty(p_s_n_in)
        p_s_n = fixed.defaultSingularValueLowerBoundProbability;
    else
        p_s_n = p_s_n_in;
    end
    m = double(m);
    n = double(n);
    p_s_n = double(p_s_n);
    fixed.internal.validation.validateTallSkinnySizes(mfilename,m,n);
    fixed.internal.validation.validateNumericScalarInClosedInterval(...
        mfilename,0,1,p_s_n);
    logY = log(p_s_n) + 2*gammaln(m-n+2) + gammaln(n) ...
           - gammaln(m+1) - gammaln(m-n+1) - log(m - n + 1);
    y = exp(logY);
    lambda = 2*gammaincinv(y, m-n+1);
    s_n = sqrt(lambda);
end
