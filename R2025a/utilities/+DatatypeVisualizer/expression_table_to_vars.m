function [E,...
          Index,...
          log2_Eps,...
          log2_MaxAbsSim,...
          log2_MaxAbsRange,...
          log2_HistCombined,...
          underflow,...
          overflow,...
          HistCombined] = expression_table_to_vars(E)
% Datatype visualization beta.
    
%   Tom Bryan and Julia Wall, 5 April 2015
%   Copyright 2015-2022 The MathWorks, Inc.

      
    % Add the positive and negative histograms, and normalize each
    % row
    I = find(cellfun(@length,E.HistogramOfPositiveValues)==256);
    if ~isempty(I)
        E = E(I,:);
        HistogramOfPositiveValues  = cell2mat(E.HistogramOfPositiveValues);
        HistogramOfPositiveValues = reshape(HistogramOfPositiveValues(:),256,length(HistogramOfPositiveValues(:))/256);
        HistogramOfNegativeValues = cell2mat(E.HistogramOfNegativeValues);
        HistogramOfNegativeValues = reshape(HistogramOfNegativeValues(:),256,length(HistogramOfNegativeValues(:))/256);
        HistCombined = HistogramOfPositiveValues + HistogramOfNegativeValues;
        HistCombined = bsxfun(@rdivide,HistCombined,sum(HistCombined,1));
        HistCombined(HistCombined==0) = nan;
    end
    
    Index           = E.Index;
    
    LineNumber      = E.LineNumber;

    IsAlwaysWholeNumber = E.IsAlwaysWholeNumber;
    
    SimMin          = E.SimMin;
    SimMax          = E.SimMax;
    MaxAbsSim       = max(abs([SimMin,SimMax]),[],2);
    
    Eps             = E.Eps;
    MinRange      = E.MinRange;
    MaxRange      = E.MaxRange;
    MaxAbsRange     = max(abs([MinRange,MaxRange]),[],2);

    underflow = E.Underflow;
    overflow  = E.Overflow;
    
    log2_Eps             = log2(double(Eps));
    log2_MaxAbsSim       = log2(double(MaxAbsSim));
    log2_MaxAbsRange     = log2(double(MaxAbsRange));
    
    if isempty(I)
        log2_HistCombined = [];
    else
        log2_HistCombined    = log2(HistCombined);
        % log2_HistCombined    = HistCombined;
        % log2_HistCombined(HistCombined==0) = nan;
    end

end
