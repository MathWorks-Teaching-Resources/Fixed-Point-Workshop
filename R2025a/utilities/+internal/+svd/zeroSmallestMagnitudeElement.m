function x = zeroSmallestMagnitudeElement(x)
    %zeroSmallestMagnitudeElement Set the smallest magnitude element to zero.
    %   x = fixed.internal.svd.zeroSmallestMagnitudeElement(x) sets the
    %   smallest magnitude element of x to zero.
    
    %   Copyright 2022 The MathWorks, Inc.
    %#codegen
    if isfi(x)
        minimumMagnitudeElement = realmax(x);
    else
        minimumMagnitudeElement = realmax('like',x);
    end
    minimumMagnitudeIndex = int32(1);
    for k = 1:length(x)
        absF = abs(x(k));
        % <= to favor small values at the end
        if ~isequal(absF,0) && absF <= minimumMagnitudeElement
            minimumMagnitudeElement(:) = x(k);
            minimumMagnitudeIndex(:) = k;
        end
    end
    x(minimumMagnitudeIndex) = 0;
end