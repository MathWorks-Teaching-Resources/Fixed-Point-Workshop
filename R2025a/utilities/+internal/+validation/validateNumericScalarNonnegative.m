function validateNumericScalarNonnegative(filename,varargin)
%fixed.validateNumericScalarNonnegative Validate that the inputs are numeric, scalar, real, and nonnegative
%
%   fixed.validateNumericScalarNonnegative(FILENAME, A, B, C, ...)
%   validates that variables A, B, C, etc. are numeric, scalar, real,
%   and nonnegative.  FILENAME is the name of the file that this function
%   is called from.
    
%   Copyright 2022 The MathWorks, Inc.
%#codegen
    for k = 1:length(varargin)
        if isempty(coder.target)
            inputnamearg = {inputname(k+1)};
        else
            % inputname is not supported in code generation.
            inputnamearg = {};
        end
        validateattributes(varargin{k},...
            {'numeric','embedded.fi','half'},...
            {'scalar','real','nonnegative'},...
            filename,inputnamearg{:});
    end
end

