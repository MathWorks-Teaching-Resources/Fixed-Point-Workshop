function  Row = find_expression_underflow(Row)
% Datatype visualization beta.
    
%   Tom Bryan and Julia Wall, 5 April 2015
%   Copyright 2015-2022 The MathWorks, Inc.

   
    % The meaning of the histogram bins: [-128,127];
    
    hist_lsb = -128;
    
    if ~isempty(Row.KnownType) && ...
            ~isempty(Row.SimMin~=0) && ...
            ~isempty(abs(Row.SimMin)<Row.Eps) && ...
            ~isempty(Row.SimMax~=0) && ...
            ~isempty(abs(Row.SimMax)<Row.Eps)
        
        Row.Underflow = Row.KnownType && ...
            ((Row.SimMin~=0 && abs(Row.SimMin)<Row.Eps) || ...
            (Row.SimMax~=0 && abs(Row.SimMax)<Row.Eps));
    end
    
    if ~isempty(Row.HistogramOfPositiveValues)
        hist_combined = Row.HistogramOfPositiveValues + ...
            Row.HistogramOfNegativeValues;
        
        smallest_bin = find(hist_combined~=0,1,'first');
        
        if ~isempty(Row.Underflow) && ~isempty(smallest_bin)
            % At least one non-zero histogram bin
            log2_smallest = smallest_bin + hist_lsb;
            if ~isempty(Row.Eps)
                log2_eps = log2(Row.Eps);
                Row.Underflow = Row.Underflow || ...
                    (Row.KnownType && ...
                    log2_smallest < log2_eps);
            end
        end
        
    end
    
end
