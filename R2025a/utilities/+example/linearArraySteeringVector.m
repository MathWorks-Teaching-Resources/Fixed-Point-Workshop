function steeringVector = linearArraySteeringVector(n,theta,d,lambda)
%linearArraySteeringVector Linear array steering vector
%   fixed.example.linearArraySteeringVector(n,theta) returns a
%   steering vector for a linear array with n linearly-spaced elements for
%   steering angle theta in radians, and half wavelength spacing.
%
%   fixed.example.linearArraySteeringVector(n,theta,d,lambda) returns a
%   steering vector for a linear array with n linearly-spaced elements for
%   steering angle theta in radians, d sensor spacing in the same units as
%   wavelength, and lambda wavelength
%
%   See also steervec.
    
%   Copyright 2021-2022 The MathWorks, Inc.
    narginchk(2,4);
    if nargin < 3
        d = 1;
    end
    d = double(d);
    if nargin < 4
        lambda = 2*d;  % Half wavelength
    end
    lambda = double(lambda);
    n = double(n);
    theta = double(theta);
    % d/lambda of this formula == d in toolbox/phased/phased/steervec.m
    % Book formula
    steeringVector = exp((0:n-1)'*(2*pi*d/lambda)*sin(theta)*1i);
end