function h = xValueDistribution(m,n,rankA,noiseStandardDeviation,x_values,estimated_largest_X,title_qualifying_text)
%fixed.example.plot.xValueDistribution Plot distribution of X values
%   h = fixed.example.plot.xValueDistribution(m,n,rankA,noiseStandardDeviation,x_values,estimated_largest_X,title_qualifying_text)
%   plots X distributions for m-by-n matrices of rank rankA with
%   noise standard deviation noiseStandardDeviation with x-values
%   x_values, estimated largest X estimated_largest_X, and title
%   qualifying text title_qualifying_text.

%   Copyright 2021-2022 The MathWorks, Inc.
    if nargin < 8
        title_qualifying_text = "";
    end
    x_values = abs(x_values(:));
    [x,y] = fixed.example.histogramCount(x_values,'probability',20);
    loglog(x,y)
    if rankA<n
        % Low rank
        title(sprintf("X distributions for %d-by-%d %s matrices of rank %d with \\sigma_{noise} = %4.3g",m,n,title_qualifying_text,rankA,noiseStandardDeviation))
    else
        % Full rank
        title(sprintf("X distributions for %d-by-%d %s matrices with \\sigma_{noise} = %4.3g",m,n,title_qualifying_text,noiseStandardDeviation))
    end
    xlabel('X value magnitude')
    ylabel('Probability')
    xline(estimated_largest_X,...
        "LineWidth",2,...
        "LabelHorizontalAlignment","left",...
        "Label","Estimated upper bound on X","HandleVisibility","off");
    h = gca;
    xLim = h.XLim;
    xLim(2) = xLim(2)*1.25;
    h.XLim = xLim;
end