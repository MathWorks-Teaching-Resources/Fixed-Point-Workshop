function [x,y] = histogramCount(h,normalization,nbins)
%histogramCount Histogram count to x, y vectors.
 %   [X,Y] = fixed.example.histogramCount(H) partitions H values into
%   20 bins and returns the count Y in each bin as well as the left
%   and right edges in X so they can be plotted.
%
%   [X,Y] = fixed.example.histogramCount(H,NORMALIZATION) also
%   accepts a normalization parameter the same as HISTCOUNT
%   normalization parameter.  The default normalization is "count".
%
%   [X,Y] = fixed.example.histogramCount(H,NORMALIZATION,NBINS)
%   also specifies the number of bins in X and Y.  The default
%   number of bins is 20.
%
%   Examples:
%
%      % Count in each bin
%      h = randn(10000,1);
%      [x,y] = fixed.example.histogramCount(h);
%      plot(x,y)
%
%      % Probability density count
%      h = randn(10000,1);
%      [x,y] = fixed.example.histogramCount(h,'pdf',40);
%      plot(x,y)
%
%      % Cumulative density count
%      h = randn(10000,1);
%      [x,y] = fixed.example.histogramCount(h,'cdf',40);
%      plot(x,y)
%
%   See also histcounts.

%   Copyright 2021-2022 The MathWorks, Inc.
    narginchk(1,3);
    if nargin<2
        normalization = 'count';
    end
    if nargin<3
        nbins = 20;
    end
    h = double(h);
    nbins = double(nbins);
    [y,edges]=histcounts(h,nbins,'Normalization',normalization);
    x=edges(1:end-1)+diff(edges)/2;
end