function plot_expression_table3(E,varargin)
%

%   Copyright 2022 The MathWorks, Inc.

    clf
    
    global PLOT_EXPRESSION_NAMES
    if isempty(PLOT_EXPRESSION_NAMES)
        PLOT_EXPRESSION_NAMES = false;
    end
    current_plot_expression_names = PLOT_EXPRESSION_NAMES;
    
    if ~isempty(E)
        
        IsAlwaysWholeNumber = true;
        
        SimMin   = -inf;
        SimMax   = +inf;
        Eps      = -inf;
        MinRange = -inf;
        MaxRange = +inf;
        Underflow = false;
        Overflow = false;
        

        % Aggregate plot
        Apos = zeros(256,1);
        Aneg = zeros(256,1);
        for n = 1:height(E)
            Epos = decell(E.HistogramOfPositiveValues(n));
            Eneg = decell(E.HistogramOfNegativeValues(n));
            if length(Epos)==256
                Apos = Apos + Epos;
                Aneg = Aneg + Eneg;
                SimMin   = max(SimMin  , E.SimMin(n)  );
                SimMax   = min(SimMax  , E.SimMax(n)  );
                Eps      = max(Eps     , E.Eps(n)     );
                MinRange = max(MinRange, E.MinRange(n));
                MaxRange = min(MaxRange, E.MaxRange(n));
                Underflow = Underflow || E.Underflow(n);
                Overflow = Overflow || E.Overflow(n);
            end
        end
        A = E(1,:);
        A.Prototype = {double([])};
        A.Class = {'double'};
        A.HistogramOfPositiveValues = {Apos};
        A.HistogramOfNegativeValues = {Aneg};
        A.SimMin   = SimMin  ;
        A.SimMax   = SimMax  ;
        A.Eps      = Eps     ;
        A.MinRange = MinRange;
        A.MaxRange = MaxRange;
        A.Underflow = Underflow;
        A.Overflow = Overflow;
        
        h2 = subplot(1,15,15);
        PLOT_EXPRESSION_NAMES = false;
        DatatypeVisualizer.plot_expression_table(A);
        title('Aggregate')

    end % if ~isempty(E)
    % Main plot
    h1 = subplot(1,15,1:14);
    PLOT_EXPRESSION_NAMES = current_plot_expression_names;
    DatatypeVisualizer.plot_expression_table(E);
    
    if ~isempty(E)
        linkaxes([h1,h2],'y');
    end
    
end

function y = decell(x)
    y = x{1};
end
