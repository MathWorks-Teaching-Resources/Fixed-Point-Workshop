function varargout = jacobiSVD(A_in,varargin)
    %fixed.jacobiSVD Fixed-point Jacobi singular value decomposition.
    %   [U,s,V] = fixed.jacobiSVD(A) uses the two-sided Jacobi method to
    %   produce a vector s of nonnegative elements in decreasing order, and
    %   unitary matrices U and V so that A = U*diag(s)*V'.  The dimensions
    %   of U, s, and V are the same as builtin SVD with the "econ" and
    %   "vector" flags: [U,s,V] = svd(A,"econ","vector")
    %
    %   s = fixed.jacobiSVD(A) returns a vector containing the singular
    %   values.
    %
    %   [...] = fixed.jacobiSVD(A,numberOfSweeps) performs numberOfSweeps Jacobi
    %   iterations.  If numberOfSweeps is not supplied, then the default is 10.
    %
    %   This function supports double, single, and fixed-point
    %   types.  Fixed-point types must be signed.  Singular values
    %   are computed in the same data type as the input.  Ensure
    %   that there are enough integer bits to prevent overflow.
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
    %      integerLength = ceil(log2(svdUpperBound)) + 2;
    %      wordLength = 32;
    %      fractionLength = wordLength - integerLength;
    %      T = fi([],1,wordLength,fractionLength);
    %      A = cast(A,'like',T);
    %      [U,s,V] = fixed.jacobiSVD(A)
    %      relativeError = norm(double(U*diag(s)*V' - A))/norm(double(A))
    %
    %   See also svd.

    % References:
    %    C. G. J. Jacobi, Uber ein leichtes Verfahren die in der Theorie
    %    der Sacularstorungen vorkommenden Gleichungen numerisch
    %    aufzulosen, Journal fur die reine und angewandte Mathematik,
    %    (1846), pp. 51–94.
    %
    %    J. R. Cavallaro and F. T. Luk, CORDIC arithmetic for an SVD
    %    processor, in 1987 IEEE 8th Symposium on Computer Arithmetic
    %    (ARITH), 1987, pp. 113–120,
    %    https://doi.org/10.1109/ARITH.1987.6158686.
    %
    %    Gene H. Golub and Charles F. Van Loan, Matrix Computations, 4th
    %    ed, Section 8.6.4 "Jacobi SVD Procedures".

    %   Copyright 2022 The MathWorks, Inc.
    %#codegen
    narginchk(1,2);
    if isempty(A_in)
        % No computation is required for empty input.
        [varargout{1:nargout}] = emptyCase(nargout,A_in);
        return
    end
    [ComputeUV,ComputeOnlyU,ComputeOnlyS] = coder.const(@decideComputations,nargout);
    % Parse the inputs. If A_in is not square, then compute the QR
    % factorization of it and return Q and the square A=R.
    [A,n,numberOfSweeps,Q,IsTransposed,T] = parseInputs(A_in,ComputeOnlyU,ComputeOnlyS,varargin{:});
    if isequal(n,2)
        % The 2-by-2 SVD has a closed-form solution and doesn't need to
        % iterate.
        [U,s,V] = fixed.internal.svd.twoByTwoOrthogonalDiagonalDecomposition(A);
    else
        % The Jacobi SVD algorithm for square matrices.
        [U,V] = initializeUV(n,IsTransposed,ComputeOnlyU,ComputeUV,T);
        for sweep = 1:numberOfSweeps
            for i=1:n-1
                for j = i+1:n
                    aij = [A(i,i),A(i,j);A(j,i),A(j,j)];
                    % s = u'*aij*v
                    [u,~,v] = fixed.internal.svd.twoByTwoOrthogonalDiagonalDecomposition(aij);
                    % Update rows i and j
                    A(:) = fixed.internal.svd.jacobiMatrixLeftUpdate(A,i,j,u);
                    % Update columns i and j
                    A(:) = fixed.internal.svd.jacobiMatrixRightUpdate(A,i,j,v);
                    A(i,j) = 0;  % Eliminate rounding error
                    A(j,i) = 0;  % Eliminate rounding error
                    U(:) = fixed.internal.svd.jacobiMatrixRightUpdate(U,i,j,u);
                    V(:) = fixed.internal.svd.jacobiMatrixRightUpdate(V,i,j,v);
                end % for j
            end % for i
        end % for sweep
        s = real(diag(A));
    end
    if isempty(Q)
        % The input was square.
        U_out = U;
    else
        % Apply the Q from the QR decomposition that was applied to the
        % non-square input to make A square.
        U_out = Q*setfimath(U,fixed.fimathLike(U));  % Changes the size of U
    end
    % Make the singular values positive, sort them, and apply the same
    % updates the singular vectors.
    [U_out(:),s(:),V(:)] = rectifyAndSort(U_out,s,V,IsTransposed,ComputeUV,ComputeOnlyU);
    [varargout{1:nargout}] = parseOutputs(nargout,U_out,s,V,IsTransposed);
end % jacobiSVD


function [A,n,numberOfSweeps,Q,IsTransposed,T] = parseInputs(A_in,ComputeOnlyU,ComputeOnlyS,varargin)
    % Parse inputs to jacobiSVD.  Return square A, the number of columns n,
    % and the number of sweeps that the Jacobi algorithm takes.  If the
    % input is not square, then compute the economy-size QR factorization
    % and return A = R (which is n-by-n), and Q which is used later to
    % update U.  Determine whether to compute both U and V, only U, or only
    % S.  The singular values S are always computed.  The table of types
    % are returned in T.
    if nargin<4 || isempty(varargin{1})
        numberOfSweeps = int32(10);
    else
        numberOfSweeps = varargin{1};
    end
    validateattributes(A_in,{'double','single','embedded.fi'},{'2d'},'fixed.jacobiSVD','A');
    validateattributes(numberOfSweeps,{'numeric','embedded.fi'},{'scalar','integer','>',0},'fixed.jacobiSVD','numberOfSweeps');
    coder.internal.assert(~isfi(A_in) || (isfi(A_in)&&issigned(A_in)),'fixed:fi:inputArgMustBeSigned',1);
    A_in1 = getFloatVersionIfNecessary(A_in);
    T = fixed.internal.svd.usv.cordicBidiagonalizationTypes(A_in1);

    [A_in2,IsTransposed] = transposeIfShortAndFat(A_in1);
    % m >= n
    m = int32(0);
    n = int32(0);
    [m(:),n(:)] = size(A_in2);
    % If A is not square, do economy-size QR first and work on A=R.
    % Update U at the end with U = C'*U.
    [Q,A] = doNonSquareIfNecessary(m,n,A_in2,ComputeOnlyU,ComputeOnlyS,IsTransposed,T);
end

function  A_in1 = getFloatVersionIfNecessary(A_in)
    % If A_in is a fi object with data type double or single, then use the
    % builtin double or single.
    if isfi(A_in) && isfloat(A_in)
        % The stored integer of floating-point fi objects is the underlying
        % builtin double or single.
        A_in1 = storedInteger(A_in);
    else
        A_in1 = A_in;
    end
end

function [ComputeUV,ComputeOnlyU,ComputeOnlyS] = decideComputations(numberOfOutputArguments)
    % Based on the number of output arguments, determine which computations are necessary.
    %   The singular values, s, are always computed.
    %   [U,s,V] = fixed.jacobiSVD(A)  Compute U and V
    %     [U,s] = fixed.jacobiSVD(A)  Compute Only U
    %         s = fixed.jacobiSVD(A)  Compute Only S
    %             fixed.jacobiSVD(A)  Compute Only S (returned in ans)
    switch numberOfOutputArguments
        case {0,1}
            ComputeUV = false;
            ComputeOnlyU = false;
            ComputeOnlyS = true;
        case 2
            ComputeUV = false;
            ComputeOnlyU = true;
            ComputeOnlyS = false;
        otherwise
            ComputeUV = true;
            ComputeOnlyU = false;
            ComputeOnlyS = false;
    end
end

function varargout = emptyCase(numberOfOutputArguments, A)
    % Special case for empty input to match the sizes of builtin SVD.  No
    % computations are necessary.
    T = fixed.internal.svd.usv.cordicBidiagonalizationTypes(getFloatVersionIfNecessary(A));
    [m,n] = size(A);
    if m<n
        U0 = cast([],'like',T.UV);
        V0 = eye(n,m,'like',T.UV);
        S0 = zeros(0,1,'like',T.B);
    else
        U0 = eye(m,n,'like',T.UV);
        V0 = eye(n,n,'like',T.UV);
        S0 = zeros(0,1,'like',T.B);
    end
    switch numberOfOutputArguments
        case 1
            varargout{1} = S0;
        case 2
            varargout{1} = U0;
            varargout{2} = S0;
        otherwise
            varargout{1} = U0;
            varargout{2} = S0;
            varargout{3} = V0;
    end

end

function [A1,IsTransposed] = transposeIfShortAndFat(A)
    % If the input is short and fat (m<n), then work on the transposed
    % version and reverse U and V on the output.
    IsTransposed = coder.const(size(A,1) < size(A,2));
    if IsTransposed
        % If there are more rows than columns, then compute the transpose SVD and
        % switch U and V.
        A1 = A';
    else
        A1 = A;
    end
end

function [Q,A] = doNonSquareIfNecessary(m,n,A_in,ComputeOnlyU,ComputeOnlyS,IsTransposed,T)
    % If the input is not square, then compute the economy-size QR
    % factorization and return A = R (which is n-by-n), and Q which is used
    % later to update U.  If Q is not needed later, then return it as
    % empty.
    if (m>n && ComputeOnlyS) || IsTransposed && ComputeOnlyU
        Q = cast([],'like',T.UV);
        A = fixed.qlessQR(A_in);
    elseif m > n
        [Q,A] = fixed.internal.qr.economyQRTallOrSquare(A_in);
    else
        Q = cast([],'like',T.UV);
        A = A_in;
    end
end

function [U,V] = initializeUV(n,IsTransposed,ComputeOnlyU,ComputeUV,T)
    % Initialize U and V to n-by-n identity matrices.  If it is not
    % computed, then it is returned as empty.
        if IsTransposed && ComputeOnlyU
            U = cast([],'like',T.UV);
            V = eye(n,'like',T.UV);
        elseif ComputeOnlyU
            U = eye(n,'like',T.UV);
            V = cast([],'like',T.UV);
        elseif ComputeUV
            U = eye(n,'like',T.UV);
            V = eye(n,'like',T.UV);
        else
            U = cast([],'like',T.UV);
            V = cast([],'like',T.UV);
        end
end

function [U,s,V] = rectifyAndSort(U,s,V,IsTransposed,ComputeUV,ComputeOnlyU)
    % Make the singular values positive and sorted.  Apply the same
    % transformations to U and V.
    if ComputeUV
        % Make the singular values positive
        [s(:),V(:)] = fixed.internal.svd.usv.rectifySingularValues(s,V);
        % Sort the singular values and apply the sorting to the singular vectors.
        [s,svd_index] = sort(s,'descend');
        U(:) = U(:,svd_index);
        V(:) = V(:,svd_index);
    elseif ComputeOnlyU && IsTransposed
        % Make the singular values positive
        [s(:),V(:)] = fixed.internal.svd.usv.rectifySingularValues(s,V);
        [s,svd_index] = sort(s,'descend');
        V = V(:,svd_index);
    elseif ComputeOnlyU
        s(:) = abs(s);
        [s,svd_index] = sort(s,'descend');
        U = U(:,svd_index);
    else
        s(:) = abs(s);
        s(:) = sort(s,'descend');
    end
end

function varargout = parseOutputs(numberOfOutputArguments,U_out,S,V,IsTransposed)
    % Deal the computed values to the outputs.  If the input was
    % transposed, then swap U and V.
    switch numberOfOutputArguments
        case {0,1}
            varargout{1} = removefimath(S);
        case 2
            if IsTransposed
                varargout{1} = removefimath(V);
            else
                varargout{1} = removefimath(U_out);
            end
            varargout{2} = removefimath(S);
        otherwise
            if IsTransposed
                varargout{1} = removefimath(V);
                varargout{3} = removefimath(U_out);
            else
                varargout{1} = removefimath(U_out);
                varargout{3} = removefimath(V);
            end
            varargout{2} = removefimath(S);
    end
end