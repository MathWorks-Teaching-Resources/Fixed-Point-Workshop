function t = is_function(fun)
% Return true if 'fun' is a function or class.
% 
% From Loren's blog: 
% https://blogs.mathworks.com/loren/2013/08/26/what-kind-of-matlab-file-is-this/

%   Copyright 2022 The MathWorks, Inc.

    try
        nargin(fun);
        t = true;
    catch
        t = false;
    end
end
