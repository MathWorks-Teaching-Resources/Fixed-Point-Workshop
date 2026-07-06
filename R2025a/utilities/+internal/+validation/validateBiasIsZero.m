function validateBiasIsZero(X)
%validateBiasIsZero Validate that if input X is a fi object, then it has zero bias

% Copyright 2020 The MathWorks, Inc.

%#codegen

    coder.internal.errorIf(isfi(X) && (X.Bias ~= 0), ...
                           'fixed:fi:inputMustHaveZeroBias');

end
