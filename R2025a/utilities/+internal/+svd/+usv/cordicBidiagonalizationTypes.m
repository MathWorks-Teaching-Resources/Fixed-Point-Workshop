function T = cordicBidiagonalizationTypes(A)
    %cordicBidiagonalizationTypes  Data types for CORDIC bidiagonalization.
    %   T = fixed.internal.svd.usv.cordicBidiagonalizationTypes(A) returns data
    %   types for U, B, and V in the CORDIC bidiagonalization of A.  These
    %   types are used by fixed.internal.svd.usv.cordicBidiagonalization.

    %   Copyright 2022 The MathWorks, Inc.
    %#codegen

    if isfi(A) && isscaledtype(A)
        TB = setfimath(cast([],'like',A),fixed.fimathLike(A));
        UV = fi([],1,A.WordLength,A.WordLength-2,'DataType',A.DataType);
        TUV = setfimath(UV,fixed.fimathLike(UV));
    else
        TB = cast([],'like',A);
        TUV = cast([],'like',A);
    end
    if isreal(A)
        T.B = TB;
        T.UV = TUV;
    else
        T.B = cast(1i,'like',TB);
        T.UV = cast(1i,'like',TUV);
    end

end
