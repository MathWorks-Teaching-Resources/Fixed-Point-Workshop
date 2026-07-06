function y = cordicDivide(num,den,OutputType)
%fixed.cordicDivide Fixed-point divide using CORDIC.
%   y = fixed.cordicDivide(num,den,OutputType) divides num by
%   den using output type specified by OutputType.
%
%   Example:
%     num = fi(1);
%     den = fi(10);
%     OutputType = numerictype(1,16,15);
%     y = fixed.cordicDivide(num,den,OutputType)

%   Copyright 2020-2021 The MathWorks, Inc.
%#codegen
    coder.internal.assert(~isempty(num) && ~isempty(den) && ...
        (isequal(size(num),size(den)) || isscalar(den) || isscalar(num)) ,...
        'fixed:fi:DimAgree');
    OutputPrototype = fixed.numerictypeToPrototype(OutputType);
    if isscalar(num)
        output_size = size(den);
    else
        output_size = size(num);
    end

    if isreal(num) && isreal(den)
        divideFunction = @fixed.internal.reciprocal.realCordicDivide;
        y = zeros(output_size,'like',OutputPrototype);
    else
        divideFunction = @fixed.internal.reciprocal.complexCordicDivide;
        y = complex(zeros(output_size,'like',OutputPrototype));
    end
    if isscalar(num)
        % Scalar numerator
        for k = 1:numel(y)
            if den(k) == 0
                y(k) = fixed.internal.reciprocal.divideByZero(num,OutputPrototype);
            else
                y(k) = divideFunction(num,den(k),OutputPrototype);
            end
        end
    elseif isscalar(den)
        % Scalar denominator
        for k = 1:numel(y)
            if den == 0
                y(k) = fixed.internal.reciprocal.divideByZero(num(k),OutputPrototype);
            else
                y(k) = divideFunction(num(k),den,OutputPrototype);
            end
        end
    else
        % size(num) == size(den)
        for k = 1:numel(y)
            if den(k) == 0
                y(k) = fixed.internal.reciprocal.divideByZero(num(k),OutputPrototype);
            else
                y(k) = divideFunction(num(k),den(k),OutputPrototype);
            end
        end
    end
end
