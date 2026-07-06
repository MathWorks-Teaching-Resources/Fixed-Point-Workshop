function codegenValidateScalingBinaryPoint(x, varargin)
%codegenValidateScalingBinaryPoint Validate that only binary-point
%scaled data is passed to code generation
%
%   FOR INTERNAL USE ONLY -- This feature is intentionally
%   undocumented. Its behavior may change, or it may be removed in a
%   future release.

%   Copyright 2019 The MathWorks, Inc.

%#codegen

% Note: This function is a static assertion at compile time and will not
% generate any run-time code
    if ~coder.target('MATLAB')
        isBpsFixed = fixed.internal.type.isFixedScalingBinaryPoint(x);
        coder.internal.assert(isBpsFixed,...
                              'fixed:coder:fixedBinaryPointOnlyCodegen', varargin{:});
    end


end
