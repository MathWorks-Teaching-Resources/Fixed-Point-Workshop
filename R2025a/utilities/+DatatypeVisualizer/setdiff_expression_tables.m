function E2 = setdiff_expression_tables(E,V)
%

%   Copyright 2022 The MathWorks, Inc.
    
    % These are the only legal fields setdiff can work with.
    % TODO: Make these named with an exception list, using fields(E).
    I = [1:4,7:54,65:67];
    % Remove things that are in the variable table
    [~,ie] = setdiff(E(:,I),V(:,I));
    % Add back in the skipped fields
    E2 = E(ie,:);
end
