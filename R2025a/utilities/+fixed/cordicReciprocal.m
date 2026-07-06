function y = cordicReciprocal(u,OutputType)
%fixed.cordicReciprocal Fixed-point reciprocal using CORDIC.
%   y = fixed.cordicReciprocal(u,OutputType) returns 1./u using
%   output type specified by OutputType.
%
%   Example:
%     u = fi(10);
%     OutputType = numerictype(1,16,15);
%     y = fixed.cordicReciprocal(u,OutputType)

%   Copyright 2021 The MathWorks, Inc.
%#codegen
    OutputPrototype = fixed.numerictypeToPrototype(OutputType);
    if isreal(u)
        reciprocalFunction = @fixed.internal.reciprocal.realCordicReciprocal;
        y = zeros(size(u),'like',OutputPrototype);
    else
        reciprocalFunction = @fixed.internal.reciprocal.complexCordicReciprocal;
        y = complex(zeros(size(u),'like',OutputPrototype));
    end
    for k = 1:numel(y)
        y(k) = reciprocalFunction(u(k),OutputPrototype);
    end
end

