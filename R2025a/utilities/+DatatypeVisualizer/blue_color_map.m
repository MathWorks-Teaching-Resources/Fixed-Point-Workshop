function blue_map = blue_color_map(M)
%

%   Copyright 2022 The MathWorks, Inc.

    if nargin<1
        M = 64;
    end
% http://cloford.com/resources/colours/500col.htm
blue_sparse_map = [
    176     226     255 % lightskyblue 1
    164     211     238 % lightskyblue 2
    141     182     205 % lightskyblue 3
    96      123     139 % lightskyblue 4
    ]/255;

 blue_map = DatatypeVisualizer.extend_color_map(blue_sparse_map,M);
end
