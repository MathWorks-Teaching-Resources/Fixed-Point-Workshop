function red_map = red_color_map(M)
%

%   Copyright 2022 The MathWorks, Inc.

    if nargin<1
        M = 64;
    end
% http://cloford.com/resources/colours/500col.htm
red_sparse_map = [
    255     48      48 % firebrick 1
    238     44      44 % firebrick 2
    205     38      38 % firebrick 3
    ]/255;

 red_map = DatatypeVisualizer.extend_color_map(red_sparse_map,M);
end
