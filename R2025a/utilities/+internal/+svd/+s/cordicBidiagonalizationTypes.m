function T = cordicBidiagonalizationTypes(A)
    %cordicBidiagonalizationTypes  Data types for CORDIC bidiagonalization.
    %   T = fixed.internal.svd.s.cordicBidiagonalizationTypes(A) returns data
    %   type for B in the CORDIC bidiagonalization of A.  This type is used by
    %   fixed.internal.svd.s.cordicBidiagonalization.

    %   Copyright 2022 The MathWorks, Inc.
    %#codegen

    TB = setfimath(cast([],'like',A),fixed.fimathLike(A));
    if isreal(A)
        T.B = TB;
    else
        T.B = cast(1i,'like',TB);
    end

end
