function h = singularValueDistribution(m,n,rankA,noiseStandardDeviation,singularValues,estimatedSingularValueLowerBound,titleQualifyingText)
%singularValueDistribution Plot distribution of singular values
%   h = fixed.example.plot.singularValueDistribution(m,n,rankA,noiseStandardDeviation,singularValues,estimatedSingularValueLowerBound,titleQualifyingText)
%   Plots the distribution of singular values where s_1 is the
%   largest, and s_n is the smallest.  The largest rankA singular
%   values correspond to the rank of the matrix. The smallest
%   n-rankA singular values correspond to the noise.

%   Copyright 2021-2022 The MathWorks, Inc.
    if nargin < 7
        titleQualifyingText = "";
    end
    for i = 1:size(singularValues,1)
        [x,y] = fixed.example.histogramCount(singularValues(i,:),'probability',20);
        semilogx(x,y)
        max_index = find(max(y)==y,1);
        text(x(max_index),y(max_index),sprintf("s_{%d}",i),...
            "HorizontalAlignment","center",...
            "VerticalAlignment","bottom");
        hold on
    end
    hold off
    title(sprintf("Singular value distributions for %d-by-%d %s matrices of rank %d with \\sigma_{noise} = %4.3g",m,n,titleQualifyingText,rankA,noiseStandardDeviation))
    xlabel('Singular value magnitude')
    ylabel('Probability')
    xline(estimatedSingularValueLowerBound,...
        "LineWidth",2,...
        "LabelHorizontalAlignment","left",...
        "Label","Estimated singular value lower bound","HandleVisibility","off");
    h = gca;
    xLim = h.XLim;
    xLim(1) = xLim(1)/2;
    h.XLim = xLim;
end