function varargout = svdMethod(A,varargin)
    %svdMethod Implementation of the fixed-point svd method.
    %   fixed.internal.svd.svdMethod is the implementation of the svd method of
    %   the fi object.  It is called from
    %   toolbox/fixedpoint/fixedpoint/+embedded/@fi/svd.m for interpreted
    %   MATLAB, and from toolbox/eml/lib/fixedpoint/@embedded/@fi/svd.m for
    %   code generation.  The svd method must be registered in the fi object as
    %   a MATLAB method in src/fitools/mcos_fi.cpp.
    %
    %   See also svd.

    %#codegen
    %   Copyright 2022 The MathWorks, Inc.
    T = fixed.internal.svd.svdMethodTypes(A);
    [varargout{1:nargout}] = fixed.svd(cast(A,'like',T),varargin{:});
end

