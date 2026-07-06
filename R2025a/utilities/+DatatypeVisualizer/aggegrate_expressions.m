function A = aggegrate_expressions(E)
% Datatype visualization beta.
    
%   Tom Bryan and Julia Wall, 5 April 2015
%   Copyright 2015-2022 The MathWorks, Inc.
    P = cell(size(E.Prototype));
    for n = 1:height(E)
        p = E.Prototype(n);
        p = p{1};
        if isfi(p)
            P{n} = qpointstr(p);
        else
            P{n} = class(p);
        end
    end
    [U,IP,IU] = unique(P);
    A = E(1:length(U),:);
    for m = 1:length(U)
        initialized = false;
        for n = 1:length(P)
            % @todo Must be a better way than looking through the whole thing - Brenda Zhuang
            % each time
            if isequal(U{m},P{n})
                Epos = decell(E.HistogramOfPositiveValues(n));
                Eneg = decell(E.HistogramOfNegativeValues(n));
                if ~initialized && length(Epos)==256
                    A(m,:) = E(n,:);
                    initialized = true;
                elseif length(Epos)==256
                    Apos = decell(A.HistogramOfPositiveValues(m));
                    Aneg = decell(A.HistogramOfNegativeValues(m));
                    Apos = Apos + Epos;
                    Aneg = Aneg + Eneg;
                    A.HistogramOfPositiveValues(m) = {Apos};
                    A.HistogramOfNegativeValues(m) = {Aneg};
                end
            end
        end
    end
end

function y = decell(x)
    y = x{1};
end
 
