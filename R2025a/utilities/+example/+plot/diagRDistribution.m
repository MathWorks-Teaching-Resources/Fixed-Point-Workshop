function h = diagRDistribution(m,n,rankA,noiseStandardDeviation,diagRValues,estimatedSingularValueLowerBound,titleQualifyingText)
%diagRDistribution Plot distribution of diagonal elements of R
%   h = fixed.example.plot.diagRDistribution(m,n,rankA,noiseStandardDeviation,singularValues,estimatedSingularValueLowerBound,titleQualifyingText)
%   plots the distribution of all diagonal elements of R from a QR
%   factorization, where r_1 is the largest, and r_n is the smallest.
    
    %   Copyright 2021-2022 The MathWorks, Inc.
    if nargin < 7
        titleQualifyingText = "";
    end
    diagRValues = sort(abs(diagRValues),1,'descend');
    for i = 1:size(diagRValues,1)
        [x,y] = fixed.example.histogramCount(diagRValues(i,:),'probability',20);
        semilogx(x,y)
        max_index = find(max(y)==y,1);
        text(x(max_index),y(max_index),sprintf("r_{%d}",i),...
            "HorizontalAlignment","center",...
            "VerticalAlignment","bottom");
        hold on
    end
    hold off
    title(sprintf("diag(R) distributions for %d-by-%d %s matrices of rank %d with \\sigma_{noise} = %4.3g",m,n,titleQualifyingText,rankA,noiseStandardDeviation))
    xlabel('diag(R) magnitude')
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