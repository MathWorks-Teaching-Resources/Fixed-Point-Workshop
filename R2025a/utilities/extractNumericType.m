function uNumericType = extractNumericType(u)
% extractNumericType extract embedded.numerictype from input
%
% Return a embedded.numerictype object that is
%   extracted from a numeric value input
% or
%   is specified by the input argument.
%
% A variety of inputs are supported.
%
%   Numeric values
%     MATLAB's 11 builtin numeric type variables
%       double, single, logical, int8, ... uint64
%     Fixed-point numeric object (fi)
%
%   Numeric Type specification objects
%     embedded.numerictype objects
%     Simulink.NumericType objects
%
%   Data Type Name Strings
%     class name of MATLAB's 11 builtin numeric types
%       'double', 'single', 'logical', 'int8', ... 'uint64'
%     Simulink's canonical name of a data type (not aliases)
%       'bool','sfix16_En3'
%
%   Constructor Strings that evaluate to a Numeric Type object
%     embedded.numerictype
%       'numerictype(1,33,55)'
%     Simulink.NumericType
%       'fixdt(0,77,22)'
%

% Copyright 2017-2018 The MathWorks, Inc.

%#codegen
    coder.inline('always')

    if fixed.internal.type.isAnyScalarString(u)
        if contains(u,'(')
            u = eval(u);
        else
            u = numerictype(u);
        end
    end

    if fixed.internal.isFiOrAnyNumericType(u)
        uNumericType = numerictype(u);
    else
        uNumericType = numerictype(class(u));
    end
end
