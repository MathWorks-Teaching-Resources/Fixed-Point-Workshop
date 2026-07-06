function An = cordicGrowthFactor(niter_in)
%cordicGrowthFactor CORDIC growth factor.
%   An = cordicGrowthFactor(NITER) returns the CORDIC growth factor
%   after NITER iterations. An quickly converges to around 1.6468.

%   Copyright 2021-2022 The MathWorks, Inc.
%#codegen
    if nargin < 1 || isempty(niter_in)
        niter = 64;
    else
        niter = niter_in;
    end
    An = prod(sqrt(1+2.^(-2*(0:double(niter)-1))));
end
