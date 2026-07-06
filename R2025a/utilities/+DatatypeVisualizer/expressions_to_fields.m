function varargout = expressions_to_fields(file_name,fun_name)
% Datatype visualization beta.
    
%   Tom Bryan and Julia Wall, 5 April 2015
%   Copyright 2015-2022 The MathWorks, Inc.

   
    if nargin<2
        fun_name = '';
    end
    
    label = file_name;
    if ~isempty(fun_name)
        label = [file_name,', ',fun_name];
    end
    
    E = read_instrumentation_table(file_name);
    
    % Index
    % FunctionName
    % FunctionID
    % Size
    % Class
    % Complex
    % DataType
    % Signedness
    % WordLength
    % FractionLength
    % lowerbound
    % upperbound
    % eps
    % SimMin
    % SimMax
    % IsAlwaysInteger
    % TextStart
    % TextEnd
    % Expression
    % LoggedField
    % Prototype
    % HistogramOfPositiveValues
    % HistogramOfNegativeValues
    
    if ~isempty(fun_name)
        if isnumeric(fun_name)
            E = E(...
                E.FunctionID==fun_name,:);
        else
            E = E(strcmp(E.FunctionName,fun_name),:);
        end
    end
    all_functions = unique(E.FunctionName);
    
    Index              = E.Index;
    
    LineNumber      = E.LineNumber;

    IsAlwaysInteger = E.IsAlwaysInteger;
    IsAlwaysInteger = IsAlwaysInteger>0;
    
    SimMin          = E.SimMin;
    SimMax          = E.SimMax;
    MaxAbsSim       = max(abs([SimMin,SimMax]),[],2);
    
    Eps             = E.eps;
    lowerbound      = E.lowerbound;
    upperbound      = E.upperbound;
    MaxAbsRange     = max(abs([lowerbound,upperbound]),[],2);
    
    % Add the positive and negative histograms, and normalize each
    % row
    HistogramOfPositiveValues  = cell2mat(E.HistogramOfPositiveValues);
    HistogramOfNegativeValues = cell2mat(E.HistogramOfNegativeValues);
    HistCombined = HistogramOfPositiveValues + HistogramOfNegativeValues;
    HistCombined = bsxfun(@rdivide,HistCombined,sum(HistCombined,2));
    HistCombined(HistCombined==0) = nan;
    
    
    underflow = SimMin~=0 & abs(SimMin)<Eps | SimMax~=0 & abs(SimMax)<Eps;
    overflow = SimMin<lowerbound | SimMax>upperbound;
    
    log2_Eps             = log2(Eps);
    log2_MaxAbsSim       = log2(MaxAbsSim);
    log2_MaxAbsRange     = log2(MaxAbsRange);
    log2_HistCombined    = log2(HistCombined);
    
    
    plot_magnitude(1,label,Index,log2_Eps,log2_MaxAbsSim,log2_MaxAbsRange,log2_HistCombined,underflow,overflow,E)
    
    % DatatypeVisualizer.plot_ratio_of_range(2,label,Index,log2_Eps,log2_MaxAbsSim,log2_MaxAbsRange,log2_HistCombined,underflow,overflow,E)

    % DatatypeVisualizer.plot_whole_numbers(3,  label,IsAlwaysInteger,Index,log2_Eps,log2_MaxAbsSim,log2_MaxAbsRange,log2_HistCombined,underflow,overflow,E)

    % DatatypeVisualizer.plot_non_whole_numbers(4,label,IsAlwaysInteger,Index,log2_Eps,log2_MaxAbsSim,log2_MaxAbsRange,log2_HistCombined,underflow,overflow,E)
    
    if nargout>0
        varargout{1} = E;
    end
    
end

