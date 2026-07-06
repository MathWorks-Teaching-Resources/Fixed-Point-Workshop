function noiseStandardDeviation = realQuantizationNoiseStandardDeviation(precisionBits)
%fixed.realQuantizationNoiseStandardDeviation Quantization noise standard deviation of a real-valued signal
%   sigma = fixed.realQuantizationNoiseStandardDeviation(precisionBits)
%   returns the noise standard deviation sigma of a real-valued
%   signal with a quantization level q = 2^-precisionBits, where precisionBits is the
%   number of bits of precision.

%   Copyright 2021 The MathWorks, Inc.
    narginchk(1,1);
    noiseStandardDeviation = (2^-double(precisionBits))/sqrt(12);
end