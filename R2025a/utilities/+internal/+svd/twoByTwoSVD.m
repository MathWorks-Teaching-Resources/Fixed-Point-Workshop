function [U,S,V] = twoByTwoSVD(a,varargin)
    %twoByTwoSVD

    %   Copyright 2022 The MathWorks, Inc.
    %#codegen

    %#codegen
    % Input must be a matrix with data type double, single, or fi.  If the
    % input is fi, then it must be signed.
    validateattributes(a,{'double','single','embedded.fi'},{'2d'},'fixed.svd','A');
    coder.internal.assert(~isfi(a) || (isfi(a)&&issigned(a)),'fixed:fi:inputArgMustBeSigned',1);
    [m,n] = size(a);
    matrixDefault = nargout > 1;
    [econFlag,matrixFlag] = fixed.internal.svd.parseSVDOptions(m,n,matrixDefault,varargin{:});
    if isfi(a) && isfloat(a)
        % The stored integer of floating-point fi objects is the underlying
        % builtin double or single.
        a = storedInteger(a);
    end
    % Compute the vector 2-by-2 svd without rectifying or sorting.
    [u,s,v] = fixed.internal.svd.twoByTwoOrthogonalDiagonalDecomposition(a);
    % Make the singular values positive
    [s,v] = fixed.internal.svd.usv.rectifySingularValues(s,v);
    % Sort the singular values and apply the sorting to the singular vectors.
    [U,S,V] = fixed.internal.svd.usv.resizeSVD(m,n,u,s,v,econFlag,matrixFlag);
    U = removefimath(U);
    S = removefimath(S);
    V = removefimath(V);
end