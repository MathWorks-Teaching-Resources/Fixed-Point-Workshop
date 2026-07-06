function s_1 = singularValueUpperBound(m,n,max_abs_A,regularizationParameter_in)
%fixed.singularValueUpperBound Upper bound of largest singular value of a matrix.
%   s_1 = fixed.singularValueUpperBound(m,n,max_abs_A) returns an upper
%   bound of the largest singular value of an m-by-n matrix A where
%   max_abs_A >= max(abs(A(:))).
%
%   s_1 = fixed.singularValueUpperBound(m,n,max_abs_A,regularizationParameter)
%   returns an upper bound of the largest singular value of matrix
%   [regularizationParameter*eye(n); A].
%
%   Example:
%
%     % Real-valued matrix
%     m = 5;
%     n = 3;
%     A = ones(m,n);
%     max_abs_A = 1;
%     s_1 = fixed.singularValueUpperBound(m,n,max_abs_A)
%     actual_largest_singular_value = max(svd(A))
%
%     % Complex-valued matrix
%     m = 5;
%     n = 3;
%     A = complex(ones(m,n),ones(m,n));
%     max_abs_A = sqrt(2);
%     s_1 = fixed.singularValueUpperBound(m,n,max_abs_A)
%     actual_largest_singular_value = max(svd(A))
%
%     % Real, random, low rank with regularization parameter
%     m = 300;
%     n = 10;
%     rankA = 3;
%     regularizationParameter = 0.01;
%     A = fixed.example.realRandomLowRankMatrix(m,n,rankA);
%     A = [regularizationParameter*eye(n);A];
%     s_1 = fixed.singularValueUpperBound(m,n,max(abs(A(:))),regularizationParameter)
%     actual_largest_singular_value = max(svd(A))

%   Copyright 2022 The MathWorks, Inc.
%#codegen
    narginchk(3,4);
    if nargin < 4
        regularizationParameter_in = [];
    end
    if isempty(regularizationParameter_in)
        regularizationParameter = 0;
    else
        regularizationParameter = regularizationParameter_in;
    end
    fixed.internal.validation.validateNumericScalarPositiveInteger(mfilename,m,n);
    fixed.internal.validation.validateNumericScalarNonnegative(mfilename,max_abs_A,regularizationParameter);
    s_1 = sqrt(double(m)*double(n))*double(max_abs_A)+abs(double(regularizationParameter));
end

