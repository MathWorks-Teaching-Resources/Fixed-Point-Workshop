function X = realUniformRandomArray(a,b,varargin)
%realUniformRandomArray Real uniformly distributed random array
%   X = fixed.example.realUniformRandomArray(a,b,siz) returns a real
%   uniformly distributed random array whose elements are between the
%   values a and b, and with size siz.

%   Copyright 2021-2022 The MathWorks, Inc.
%#codegen
    a = double(a);
    b = double(b);
    X = (b-a)*rand(varargin{:}) + a;
end
