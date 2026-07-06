function validateNumericScalarInClosedInterval(filename,minValue,maxValue,varargin)
%fixed.validateNumericScalarInClosedInterval Validate that the inputs are 
% numeric, scalar, real, and in the open interval (minValue, maxValue).
%
%   fixed.validateNumericScalarInClosedInterval(FILENAME, A, B, C, ...)
%   validates that variables A, B, C, etc. are numeric, scalar, real, and
%   minValue <= A <= maxValue, and minValue <= B <= maxValue, etc. FILENAME
%   is the name of the file that this function is called from.
    
%   Copyright 2022 The MathWorks, Inc.
%#codegen
    for k = 1:length(varargin)
        if isempty(coder.target)
            inputnamearg = {inputname(k+3)};
        else
            % inputname is not supported in code generation.
            inputnamearg = {};
        end        
        validateattributes(varargin{k},...
            {'numeric','embedded.fi','half'},...
            {'scalar','real',...
            '>=',minValue,'<=',maxValue},...
            filename,inputnamearg{:});
    end
end
