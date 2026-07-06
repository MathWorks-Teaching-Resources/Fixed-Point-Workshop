function noiseStandardDeviation = complexQuantizationNoiseStandardDeviation(precisionBits)
%fixed.complexQuantizationNoiseStandardDeviation Quantization noise standard deviation of a complex-valued signal
%   sigma = fixed.complexQuantizationNoiseStandardDeviation(precisionBits)
%   returns the noise standard deviation sigma of a complex-valued
%   signal with a quantization level q = 2^-precisionBits, where precisionBits is the
%   number of bits of precision.

%   Copyright 2021 The MathWorks, Inc.
    narginchk(1,1);
    noiseStandardDeviation = (2^-double(precisionBits))/sqrt(6);
end