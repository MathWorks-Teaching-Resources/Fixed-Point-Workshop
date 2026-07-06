function X = complexUniformRandomArray(a,b,varargin)
%complexUniformRandomArray Complex uniformly distributed random array
%   X = fixed.example.complexUniformRandomArray(a,b,siz) returns a complex
%   uniformly distributed random array whose real and imaginary
%   elements are between the values a and b, and with size siz.

%   Copyright 2021-2022 The MathWorks, Inc.
    a = double(a);
    b = double(b);
    X = (b-a)*complex(rand(varargin{:}),rand(varargin{:})) + complex(a,a);
end
