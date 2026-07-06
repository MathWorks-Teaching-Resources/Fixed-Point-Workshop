function [dynamic_range, I_first, I_last] = find_dynamic_range(log2_HistCombined)
% Datatype visualization beta.
    
%   Tom Bryan and Julia Wall, 5 April 2015
%   Copyright 2015-2022 The MathWorks, Inc.

    I_first = zeros(size(log2_HistCombined,2),1);
    I_last = zeros(size(log2_HistCombined,2),1);
    for n = 1:size(log2_HistCombined,2)
        first = find(~isnan(log2_HistCombined(:,n)),1,'first');
        if ~isempty(first)
            I_first(n) = first;
            last = find(~isnan(log2_HistCombined(:,n)),1,'last');
            I_last(n) = last;
        end
    end
    dynamic_range = I_first-I_last;
end
