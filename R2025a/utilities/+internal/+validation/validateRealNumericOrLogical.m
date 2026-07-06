function validateRealNumericOrLogical(x, callingFile)
%validateRealNumericOrLogical Validate that input is real and numeric or
%logical
%
%   FOR INTERNAL USE ONLY -- This feature is intentionally
%   undocumented. Its behavior may change, or it may be removed in a
%   future release.

% Copyright 2019 The MathWorks, Inc.

%#codegen

    narginchk(1,2);

    validateattributes(x, {'embedded.fi','numeric','logical'},...
                       {'real'}, callingFile);

end
