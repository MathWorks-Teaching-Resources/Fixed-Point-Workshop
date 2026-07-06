function validateFixedOrInteger(x, callingFunction)
%validateFixedOrInteger Validate that input is fixed-point or integer
%
%   FOR INTERNAL USE ONLY -- This feature is intentionally
%   undocumented. Its behavior may change, or it may be removed in a
%   future release.

% Copyright 2019 The MathWorks, Inc.

%#codegen

    mlIntTypes = fixed.internal.type.namesMATLABInts();
    validateattributes(x, {mlIntTypes{:}, 'embedded.fi'}, {'finite'}, callingFunction)
    if isfi(x)
        coder.internal.assert(isfixed(x), 'fixed:fi:unsupportedDataType', x.DataType);
    end

end
