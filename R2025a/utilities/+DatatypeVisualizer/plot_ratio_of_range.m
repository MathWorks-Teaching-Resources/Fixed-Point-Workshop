function plot_ratio_of_range(fig,label,Index,log2_Eps,log2_MaxAbsSim,log2_MaxAbsRange,log2_HistCombined,underflow,overflow,E)
% Datatype visualization beta.
    
%   Tom Bryan and Julia Wall, 5 April 2015
%   Copyright 2015-2022 The MathWorks, Inc.

    
    [~,I] = sort(log2_MaxAbsRange-log2_MaxAbsSim,'ascend');
    
    my_title = 'Ratio of range';
    if ~isempty(log2_HistCombined)
        log2_HistCombined = log2_HistCombined(I,:);
    end
    plot_me(fig,label,my_title,Index(I),log2_Eps(I),log2_MaxAbsSim(I),log2_MaxAbsRange(I),log2_HistCombined,underflow(I),overflow(I),E)
    
end
