function validateThatDTOIsOff(fname)
%validateThatDTOIsOff Validate that Data Type Override is turned off

% Copyright 2019 The MathWorks, Inc.

%#codegen

    coder.extrinsic('fixed.internal.getDTOMode');

    s = coder.const(fixed.internal.getDTOMode());
    validatestring(s, {'ForceOff'}, fname);

end
