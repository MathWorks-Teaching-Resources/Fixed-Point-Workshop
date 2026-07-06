function T = svdMethodTypes(A)
    %svdMethodTypes Data types for fixed-point svd method.
    %   T = fixed.internal.svd.svdMethodTypes(A) returns fixed-point prototypes
    %   based on A that will not overflow and have a minimum precision.  This
    %   function is used by the svd method of the fi object.
    %
    %   See also svd.

    %   Copyright 2022 The MathWorks, Inc.
    %#codegen
    validateattributes(A,{'double','single','embedded.fi'},{'2d'},'fixed.svd','A');
    if ~isempty(A) && isfi(A) && isscaledtype(A)
        [m,n] = size(A);
        % Adjust types for fixed-point to ensure no overflow and have a
        % minimum precision: sqrt(2) accommodates complex valued input;
        % cordicGrowthFactor accommodates intermediate growth.  We don't
        % special-case for real and complex because complexity is ambiguous
        % at this time during the compilation in a MATLAB function block,
        % and accommodating for complex will also work for real.
        maxA = sqrt(2) * fixed.cordicGrowthFactor() * double(upperbound(A));
        % Ensure that svdUpperBound is positive and finite.  For example,
        % double(upperbound(fi(zeros(5,3),0,1,-1024))) returns inf.  Otherwise
        % log2(singularValueUpperBound) is going to blow up.
        svdUpperBound = min(realmax, fixed.singularValueUpperBound(m,n,maxA));
        % The integer length accommodates the upper bound on the singular
        % values plus an additional bit for the sign.
        minimumIntegerLength = ceil(log2(svdUpperBound)) + 1;
        % The minimum fraction length is 16 to allow for accurate
        % computation of the SVD, for example if A's fraction length is 0.
        fractionLength = max(16, A.FractionLength);
        % The minimum word length is 32 to allow for accurate computation
        % of the SVD.  For example, if A's word length is 1.  Also, allow
        % for growth in the SVD.
        wordLength = max([32, A.WordLength, fractionLength + minimumIntegerLength]);
        % Preserve data type (Fixed or ScaledDouble)
        T = fi([],1,wordLength,fractionLength,'DataType',A.DataType);
    else
        T = cast([],'like',A);
    end
end
