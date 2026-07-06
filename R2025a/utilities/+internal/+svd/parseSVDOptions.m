function [econFlag,matrixFlag] = parseSVDOptions(m,n,matrixDefault,varargin)
    %parseSVDOptions Parse singular value decomposition options.
    %   [econFlag,matrixFlag] = fixed.internal.svd.parseSVDOptions(m,n,matrixDefault,...)
    %   parses the input options to the svd function.
    %
    %   matrixDefault is true for [U,S,V] = svd(A,...).
    %
    %   econFlag is true for svd(A,'econ',...) and svd(A,0) when A is tall and
    %   skinny.
    %
    %   matrixFlag is true for svd(A,'matrix',...) and [U,S,V]=svd(A)

    %   Copyright 2022 The MathWorks, Inc.
    %#codegen
    % Adapted from toolbox/eml/lib/matlab/matfun/svd.m

    ONE = int32(1);
    matrixFlag = matrixDefault;
    econFlag = false;
    econSupplied = false;
    vectorMatrixFlagSupplied = false;
    coder.unroll;
    for k = 1:nargin-3
        if coder.internal.isTextRow(varargin{k})
            % svd(A,...'econ'...), svd(A,...'matrix'...)
            len = max(ONE,strlength(varargin{k}));
            if coder.const(strncmpi(varargin{k},'econ',len))
                coder.internal.assert(~econSupplied, ...
                    'MATLAB:svd:repeatedEconomyFlag');
                econFlag = true;
                econSupplied = true;
            elseif coder.const(strncmpi(varargin{k},'vector',len))
                coder.internal.assert(~vectorMatrixFlagSupplied, ...
                    'MATLAB:svd:repeatedShapeFlag');
                matrixFlag = false;
                vectorMatrixFlagSupplied = true;
            elseif coder.const(strncmpi(varargin{k},'matrix',len))
                coder.internal.assert(~vectorMatrixFlagSupplied, ...
                    'MATLAB:svd:repeatedShapeFlag');
                matrixFlag = true;
                vectorMatrixFlagSupplied = true;
            else
                coder.internal.assert(false, ...
                    'MATLAB:svd:invalidOption');
            end
        else
            % svd(A,0)
            coder.internal.assert(isscalar(varargin{k}) && varargin{k} == 0, ...
                'MATLAB:svd:invalidOption');
            if m > n
                % For m > n, svd(A,0) is equivalent to svd(A,'econ')
                econFlag = true;
            else
                % For m <= n, svd(X,0) is equivalent to svd(X).
                econFlag = false;
            end
            econSupplied = true;
        end
    end
end