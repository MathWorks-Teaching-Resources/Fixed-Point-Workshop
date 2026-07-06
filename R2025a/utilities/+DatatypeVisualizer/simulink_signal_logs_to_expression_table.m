function E = simulink_signal_logs_to_expression_table(logsout)
% Datatype visualization beta.
    
%   Tom Bryan and Julia Wall, 5 April 2015
%   Copyright 2015-2022 The MathWorks, Inc.

    log_names = logsout.getElementNames;
    log_names = sort(log_names);
    log_values = cell(size(log_names));
    for i = 1:length(log_names)
        log_values{i} = logsout.get(log_names{i}).Values.Data;
    end

    edges = -127.5:127.5;

    E = DatatypeVisualizer.empty_row();
    for i = 1:length(log_names)
        E(i) = DatatypeVisualizer.empty_row();
        E(i).Index = i;
        E(i).Expression = log_names{i};
        x = log_values{i};
        x_double = double(x);
        pos = histc(log2(x_double(x_double>0)),edges);
        neg = histc(log2(x_double(x_double<0)),edges);
        E(i).HistogramOfPositiveValues = pos(:);
        E(i).HistogramOfNegativeValues = neg(:);
        E(i).SimMin = min(x_double(:));
        E(i).SimMax = max(x_double(:));
        E(i).Prototype = x(1);
        if isfi(x)
            E(i).Eps = double(eps(x(1)));
            E(i).MinRange = double(lowerbound(x));
            E(i).MaxRange = double(upperbound(x));
        else
            E(i).Eps = realmin;
            E(i).MinRange = -realmax;
            E(i).MaxRange = realmax;
        end
    end

    E = struct2table(E);
end
    
