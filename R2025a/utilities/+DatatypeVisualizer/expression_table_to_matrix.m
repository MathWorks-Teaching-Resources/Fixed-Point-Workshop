function [PN,P,N,E] = expression_table_to_matrix(E,max_rows)
    %expression_table_to_matrix Copy histogram data from expression-table to matrix.
    %
    % [PN,P,N,E] = expression_table_to_matrix(E,max_rows) returns the sum of positive
    % and negative histograms in PN, positive histogram in P, negative
    % histogram in N.
    %
    % The expression table E is returned sorted by type and limited to
    % max_number rows.  If max_rows is not input, then it is 300.
    %
    % The histograms are in rows 1:256.  The following rows contain
    % 257 Signedness (1=signed, 0=unsigned)
    % 258 WordLength
    % 259 FractionLength
    % 260 Any overflows occurred (1=at least one overflow, 0=no overflows)
    % 261 Any underflows occurred (1=at least one underflow, 0=no underflows)
    % 262 Maximum count in a bin
    % 263 Minimum count in a bin
    %
    % For Javascript prototype only

%   Copyright 2022 The MathWorks, Inc.

    if nargin<2
        max_rows = 300;
    end
    NHIST = 256;
    E = fixup_full_histogram(E,NHIST);
    E = fixup_non_fixed_point(E);
    E = sort_by_type_and_magnitude(E);
    E = decimate_me(E,max_rows);
    P  = cell2mat(E.HistogramOfPositiveValues);
    P = reshape(P(:),NHIST,length(P(:))/NHIST);
    N = cell2mat(E.HistogramOfNegativeValues);
    N = reshape(N(:),NHIST,length(N(:))/NHIST);
    PN = P+N;
    
    additional_rows = [
        fixup_missing(E.Signed,0)
        fixup_missing(E.WordLength,NHIST)
        fixup_missing(E.FractionLength,128)
        fixup_missing(E.Overflow,0)
        fixup_missing(E.Underflow,0)
        ];
    
    PN = [PN
        additional_rows
        max(PN)
        min(PN)];
    
    P = [P
        additional_rows
        max(P)
        min(P)];
    
    N = [N
        additional_rows
        max(N)
        min(N)];
    
end

function E = fixup_full_histogram(E,NHIST)
    I = find(cellfun(@length,E.HistogramOfPositiveValues)==NHIST);
    E = E(I,:); %#ok<FNDSB>
end

function S = sort_by_type_and_magnitude(E)
    x = [E.SimMax E.SimMin];
    x = max(abs(x)'); %#ok<UDIM>
    [~,I] = sortrows([E.WordLength,E.FractionLength,x(:)],[-1,2,-3]);
    S = E(I,:);
end

function E = decimate_me(E,max_rows)
    if size(E,1) > max_rows
        N = size(E,1);
        skip = max(floor(N/max_rows),1);
        E = E(1:skip:N,:);
    end
end

function E = fixup_non_fixed_point(E)
    I = strcmp(E.Class,'double');
    if any(I)
        E(I,'WordLength') = {256};
        E(I,'FractionLength') = {128};
    end
    I = strcmp(E.Class,'single');
    if any(I)
        E(I,'WordLength') = {256};
        E(I,'FractionLength') = {128};
    end
end

function v = fixup_missing(v,replacement)
    v(~isfinite(v)) = replacement;
    v = double(v(:)');
end


