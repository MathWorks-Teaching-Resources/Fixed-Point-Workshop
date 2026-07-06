function validateInputsToStatFunctions(x,fnname)%#codegen
%VALIDATE_INPUTS_TO_STAT_FUNCTIONS Internal use only: check inputs to mean, median.
%   Validate that the input is (a) not a slope-bias scaled FI, and (b) not a FI-boolean.

%   Copyright 2009-2021 The MathWorks, Inc.
%     

coder.internal.errorIf(isfi(x) && isscalingslopebias(x), 'fixed:fi:unsupportedSlopeBias', fnname);
coder.internal.errorIf(fixed.internal.type.isAnyBoolean(x), 'fixed:fi:unsupportedBooleanMath');

end
