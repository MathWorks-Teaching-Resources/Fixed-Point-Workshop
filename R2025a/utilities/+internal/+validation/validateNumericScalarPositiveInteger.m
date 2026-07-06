function validateNumericScalarPositiveInteger(filename,varargin)
    %fixed.validateNumericScalarPositiveInteger Validate that the inputs are numeric, scalar, real, positive, and integer-valued.
    %
    %   fixed.validateNumericScalarPositiveInteger(FILENAME, A, B, C, ...)
    %   validates that variables a, b, c, etc. are numeric, scalar, real,
    %   positive, and integer valued.  FILENAME is the name of the file
    %   that this function is called from.

    %   Copyright 2021-2022 The MathWorks, Inc.
    %#codegen
    for k = 1:length(varargin)
        % "inputname" is not supported in code generation, so only use it
        % in MATLAB to give additional information about the variable that
        % doesn't meet the required attributes.
        if isempty(coder.target)
            inputnamearg = {inputname(k+1)};
        else
            % inputname is not supported in code generation.
            inputnamearg = {};
        end
        validateattributes(varargin{k},...
            {'numeric','embedded.fi','half'},...
            {'scalar','real','positive','integer'},...
            filename,inputnamearg{:});
    end
end
