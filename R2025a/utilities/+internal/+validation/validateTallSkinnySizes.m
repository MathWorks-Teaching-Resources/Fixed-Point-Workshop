function validateTallSkinnySizes(filename,m,n)
%fixed.validateTallSkinnySizes Validate that the inputs are 
% numeric, scalar, real, and m>=n.
%
%   fixed.validateNumericScalarInClosedInterval(FILENAME, m, n)
%   validates that variables m and n are numeric, scalar, real, and
%   positive, and minValue <= A <= maxValue, and minValue <= B <= maxValue,
%   etc. FILENAME is the name of the file that this function is called
%   from.
    
%   Copyright 2022 The MathWorks, Inc.
%#codegen
    fixed.internal.validation.validateNumericScalarPositiveInteger(...
        filename,m,n);
    coder.internal.assert(m >= n,'fixed:emblib:MustBeTallAndSkinnySizes','m','n');
end
