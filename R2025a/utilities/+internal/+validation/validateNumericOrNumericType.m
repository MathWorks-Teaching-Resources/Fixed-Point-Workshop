function validateNumericOrNumericType(filename,varargin)
    %fixed.validateNumericOrNumericType Validate that the inputs are numeric or numerictype
    %   fixed.validateNumericOrNumericType(FILENAME, A, B, C, ...)
    %   validates that variables a, b, c, etc. are numeric or numerictype.
    %   FILENAME is the name of the file that this function is called from.

    %   Copyright 2022 The MathWorks, Inc.
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
            {'numeric','embedded.fi','half','logical',...
            'embedded.numerictype','Simulink.NumericType'},...
            {},...
            filename,inputnamearg{:});
    end
end
