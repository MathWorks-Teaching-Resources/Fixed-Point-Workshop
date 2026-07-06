function y = quantizescaleddouble(x)
%

%   Copyright 2022 The MathWorks, Inc.

    if DatatypeVisualizer.DO_QUANTIZE_SCALED_DOUBLE() && isfi(x) && isscaleddouble(x)
        u = (double(x)-x.Bias)/x.Slope;
        switch x.RoundingMethod
            case 'Ceiling'
                u = ceil(u);
            case 'Convergent'
                u = convergent(u);
            case 'Zero'
                u = fix(u);
            case 'Floor'
                u = floor(u);
            case 'Nearest'
                u = nearest(u);
            case 'Round'
                u = round(u);
            otherwise
                error('Unrecognized rounding method');
        end
        y = cast(u*x.Slope + x.Bias,'like',x);
    else
        y = x;
    end
end
