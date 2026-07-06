function T = extractNumericType(X)
%extractNumericType Extract embedded.numerictype from input.
%   T = fixed.extractNumericType(X) returns an embedded.numerictype
%   object that is extracted from numeric value input X, or is
%   specified by the input argument X.
%
% The following inputs are supported.
%
%   Numeric values:
%     MATLAB's 11 builtin numeric type variables
%       double, single, logical, int8, ... uint64
%     Half-precision floating-point (half)
%     Fixed-point numeric object (fi)
%
%   Numeric type specification objects:
%     embedded.numerictype objects
%     Simulink.NumericType objects
%
%   Data type name strings:
%     Class name of MATLAB's 11 builtin numeric types
%       'double', 'single', 'logical', 'int8', ... 'uint64'
%     Simulink's canonical name of a data type (not aliases)
%       'bool','sfix16_En3'
%
%   Constructor strings that evaluate to a numeric type object:
%     embedded.numerictype
%       'numerictype(1,33,55)'
%     Simulink.NumericType
%       'fixdt(0,77,22)'
%
% Examples:
%
% % To extract the numeric type from a numeric value:
%     T = fixed.extractNumericType(pi)                      % numerictype('double')
%     T = fixed.extractNumericType(single(pi))              % numerictype('single')
%     T = fixed.extractNumericType(half(pi))                % numerictype('half')
%     T = fixed.extractNumericType(int8(0))                 % numerictype(1,8,0)
%     T = fixed.extractNumericType(fi(pi,1,24,12))          % numerictype(1,24,12)
%
% % To extract the numeric type from a numeric type specification object:
%     T = fixed.extractNumericType(numerictype(1,32,16))    % numerictype(1,32,16)
%     T = fixed.extractNumericType(fixdt(0,18,0))           % numerictype(0,18,0)
%
% % To extract the numeric type from a data type name string:
%     T = fixed.extractNumericType('int8')                  % numerictype(1,8,0)
%     T = fixed.extractNumericType('sfix16_En3')            % numerictype(1,16,3)
%
% % To extract the numeric type from a constructor string:
%     T = fixed.extractNumericType('numerictype(1,33,55)')  % numerictype(1,33,55)
%     T = fixed.extractNumericType('fixdt(0,77,22)')        % numerictype(0,77,22)
%
% See also fi, numerictype, fixdt.


% Copyright 2020-2021 The MathWorks, Inc.

%#codegen
    coder.inline('always')

    T = fixed.internal.type.extractNumericType(X);
end
