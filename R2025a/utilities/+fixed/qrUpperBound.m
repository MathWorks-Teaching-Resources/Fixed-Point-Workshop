function upperBound = qrUpperBound(m,maxAbs,regularizationParameter)
%fixed.qrUpperBound Upper bound for QR factorization
%   upperBound = fixed.qrUpperBound(m,maxAbs) returns the upper
%   bound of the magnitude of the elements of a QR factorization of
%   a matrix with m rows.
%
%   upperBoundR = fixed.qrUpperBound(m,max(abs(A(:)))) returns the
%   upperbound of the magnitude of upper-triangular factor R from
%   the QR factorization of matrix A with m rows.
%
%   upperBoundR = fixed.qrUpperBound(m,max(abs(A(:))),regularizationParameter) returns the
%   upperbound of the magnitude of upper-triangular factor R from
%   the QR factorization of matrix
%   [regularizationParameter*eye(n); A] where A has m rows and n columns.
%
%   upperBoundC = fixed.qrUpperBound(m,max(abs(B(:)))) returns the
%   upperbound of the magnitude of C = Q'B from the matrix equation
%   AX = B where Q is the orthogonal factor from the QR
%   factorization of matrix A with m rows.

%   Copyright 2021 The MathWorks, Inc.
    narginchk(2,3);
    if nargin < 3
        regularizationParameter = [];
    end
    if isempty(regularizationParameter)
        regularizationParameter = 0;
    end
    % Add regularizationParameter to the upper bound of matrix A.
    upperBound = sqrt(double(m))*double(abs(maxAbs)) + abs(double(regularizationParameter));
end