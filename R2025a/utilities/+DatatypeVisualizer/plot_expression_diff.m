function [RGB,zero,ylimit,ylimits] = plot_expression_diff(E1,E2,varargin)
    % Datatype visualization beta.
    
    %   Tom Bryan and Julia Wall, 5 April 2015
    %   Copyright 2015-2022 The MathWorks, Inc.
    
    % Interleave the expression tables with a fill
    % row between pairs
    global PLOT_EXPRESSION_NAMES
    PLOT_EXPRESSION_NAMES = true;
    
    
    row = 0;
    for n = 1:height(E1)
        row = row + 1;
        E(row,:) = E1(n,:);
        E(row,:).Expression = {['Run 1: ',E1(n,:).Expression{1}]};
        row = row + 1;
        if n <= height(E2)
            E(row,:) = E2(n,:);
            E(row,:).Expression = {['Run 2: ',E2(n,:).Expression{1}]};
        end
        if n < height(E1) && n <= height(E2)
            % Add fill row in between
            row = row + 1;
            E(row,:) = E2(n,:);
            E(row,:).MinRange = 0;
            E(row,:).MaxRange = 0;
            E(row,:).Expression = {''};
            E(row,:).HistogramOfNegativeValues = {nan(256,1)};
            E(row,:).HistogramOfPositiveValues = {nan(256,1)};
        end
    end
    [RGB,zero,ylimit,ylimits] = DatatypeVisualizer.plot_expression_table(E,varargin{:});
    
end
