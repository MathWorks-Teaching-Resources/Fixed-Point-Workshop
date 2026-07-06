function validateBPSFi(varargin)%#codegen
%validateBPSFi Validate that inputs are binary-point scaled fi objects
% fixed.internal.validation.validateBPSFi(fiObj1, fiObj2, ... , fiObjN, mfilename)
% validates that inputs fiObj1, fiObj2, ... , fiObjN to mfilename  are all
% binary-point scaled fi objects.
%
%   FOR INTERNAL USE ONLY -- This feature is intentionally
%   undocumented. Its behavior may change, or it may be removed in a
%   future release.

% Copyright 2020 The MathWorks, Inc.

fileName = varargin{end};
for ii = 1:nargin-1
    fiObj = varargin{ii};
    coder.internal.assert(isfi(fiObj) && isscalingbinarypoint(fiObj), ...
        'fixed:fi:binaryPointOnlyMath',  fileName);
end

end