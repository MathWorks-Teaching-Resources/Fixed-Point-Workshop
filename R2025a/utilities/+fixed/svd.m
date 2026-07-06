function [U,S,V] = svd( A, varargin)
    %fixed.svd Fixed-point singular value decomposition.
    %   [U,S,V] = fixed.svd(A) produces a diagonal matrix S, of the same
    %   dimension as A and with nonnegative diagonal elements in decreasing
    %   order, and unitary matrices U and V so that A = U*S*V'.
    %
    %   S = fixed.svd(A) returns a vector containing the singular values.
    %
    %   [U,S,V] = fixed.svd(A,"econ") produces the "economy size"
    %   decomposition. If A is m-by-n then
    %     m > n  - only the first n columns of U are computed, S is n-by-n.
    %     m == n - equivalent to fixed.svd(A)
    %     m < n  - only the first m columns of V are computed, S is m-by-m.
    %
    %   [U,S,V] = fixed.svd(A,0) produces a different economy-size
    %   decomposition of m-by-n matrix A:
    %     m > n  - fixed.svd(A,0) is equivalent to fixed.svd(A, "econ")
    %     m <= n - fixed.svd(A,0) is equivalent to fixed.svd(A)
    %   Note: This syntax is not recommended. Use the "econ" option instead.
    %
    %   [...] = fixed.svd(...,sigmaForm) returns singular values in the form
    %   specified by sigmaForm using any of the previous input or output
    %   argument combinations. sigmaForm can be "vector" to return the singular
    %   values in a vector, or "matrix" to return them in a diagonal matrix.
    %
    %   This function supports double, single, and fixed-point
    %   types.  Fixed-point types must be signed.  Singular values
    %   are computed in the same data type as the input.  Ensure
    %   that there are enough integer bits to prevent overflow.  The svd
    %   function with fixed-point inputs automatically grows the data type
    %   to avoid overflow.
    %
    %   Example:
    %
    %      m = 5;
    %      n = 3;
    %      A = 10*randn(m,n);
    %      svdUpperBound = fixed.singularValueUpperBound(m,n,max(abs(A(:))))
    %      % The integer length accommodates the upper bound on the singular
    %      % values plus two bits.  One additional bit for the sign and one
    %      % bit for intermediate CORDIC growth.
    %      integerLength = ceil(log2(svdUpperBound)) + 2
    %      wordLength = 32
    %      fractionLength = wordLength - integerLength
    %      T = fi([],1,wordLength,fractionLength)
    %      A = cast(A,"like",T);
    %      [U,S,V] = fixed.svd(A,"econ")
    %      relativeError = norm(double(U*S*V' - A))/norm(double(A))
    %
    %   See also svd.

    % References:
    %    Gene H. Golub and Charles F. Van Loan, Matrix Computations, 4th
    %    ed, Section 8.6.3 "The SVD Algorithm"

    %   Copyright 2022 The MathWorks, Inc.
    %#codegen

    % Input must be a matrix with data type double, single, or fi.  If the
    % input is fi, then it must be signed.
    validateattributes(A,{'double','single','embedded.fi'},{'2d'},'fixed.svd','A');
    coder.internal.assert(~isfi(A) || (isfi(A)&&issigned(A)),'fixed:fi:inputArgMustBeSigned',1);
    [m,n] = size(A);
    matrixDefault = nargout > 1;
    [econFlag,matrixFlag] = fixed.internal.svd.parseSVDOptions(m,n,matrixDefault,varargin{:});
    if isfi(A) && isfloat(A)
        % The stored integer of floating-point fi objects is the underlying
        % builtin double or single.
        A = storedInteger(A);
    end

    if nargout <= 1
        % Return the singular values in the first output argument, U.
        U = fixed.internal.svd.s.svdAnySize(A, econFlag, matrixFlag);
    else
        [U,S,V] = fixed.internal.svd.usv.svdAnySize(A, econFlag, matrixFlag);
    end
end
