function p_s = defaultSingularValueLowerBoundProbability(stdDev)
%fixed.defaultSingularValueLowerBoundProbability Default singular value lower bound probability
%        p_s = fixed.defaultSingularValueLowerBoundProbability is the
%        default probability that the estimate of the lower bound of
%        the smallest singular value is larger than the actual
%        smallest singular value.  The default value is p_s =
%        (1/2)*(1+erf(-5/sqrt(2))) which is 5 standard deviations
%        below the mean, so the probability that the estimated
%        lower bound for the smallest singular value is less than the
%        actual smallest singular value is 1 - p_s = 0.9999997.
%
%        p_s = fixed.defaultSingularValueLowerBoundProbability(stdDev)
%        returns p_s = (1/2)*(1+erf(-stdDev/sqrt(2))).

%   Copyright 2021-2022 The MathWorks, Inc.
%#codegen
    if nargin < 1
        stdDev = 5;
    end
    p_s = (1+erf(-double(stdDev)/sqrt(2)))/2; % stdDev standard deviations below the mean
end