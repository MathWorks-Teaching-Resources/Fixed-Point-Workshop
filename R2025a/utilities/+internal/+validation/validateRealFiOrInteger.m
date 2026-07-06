function validateRealFiOrInteger(x, varargin)
%validateRealFiOrInteger Validate that input is fixed-point or a built-in integer
%
%   FOR INTERNAL USE ONLY -- This feature is intentionally
%   undocumented. Its behavior may change, or it may be removed in a
%   future release.

% Copyright 2019 The MathWorks, Inc.

%#codegen

    narginchk(1,2);
    
    namesMlInts = fixed.internal.type.namesMATLABInts();
    validateattributes(x, {'embedded.fi', namesMlInts{:}},...
                       {'real'}, varargin{:});

end
