function orange_map = orange_color_map(M)
%

%   Copyright 2022 The MathWorks, Inc.


    if nargin<1
        M = 64;
    end
% http://cloford.com/resources/colours/500col.htm
orange_sparse_map = [
    255    193     37  % 'goldenrod 1'
    255    165      0  % 'orange'
    255    140      0  % 'darkorange'
    255    127      0  % 'darkorange 1'
    238    118      0  % 'darkorange 2'
    205    102      0  % 'darkorange 3'
    139     69      0  % 'darkorange 4'
    ]/255;

 orange_map = DatatypeVisualizer.extend_color_map(orange_sparse_map,M);
end
