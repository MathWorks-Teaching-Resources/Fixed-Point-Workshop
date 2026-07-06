function X = complexNormalRandomArray(mu,sigma,varargin)
%complexNormalRandomArray Complex normally distributed random array
%   X = fixed.example.complexNormalRandomArray(mu,sigma,siz) returns a complex
%   uniformly distributed random array whose real and imaginary
%   elements are normally distributed with mean mu, variance sigma, and
%   size siz.

%   Copyright 2021-2022 The MathWorks, Inc.
    mu = double(mu);
    sigma = double(sigma);
    X = complex(mu,mu) + (sigma/sqrt(2)) * complex(randn(varargin{:}),randn(varargin{:}));
end
