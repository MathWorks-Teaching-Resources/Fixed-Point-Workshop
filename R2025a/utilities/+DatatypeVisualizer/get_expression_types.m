function Expression_Types = get_expression_types(E)
% Datatype visualization beta.
    
%   Tom Bryan and Julia Wall, 5 April 2015
%   Copyright 2015-2022 The MathWorks, Inc.

  
    Functions = unique(E(:,'FunctionName'));
    nf = height(Functions);

    Classes = unique(E(:,'Class'));
    nc = height(Classes);

    
    bins = zeros(nf,nc);

    for i = 1:nf
        F = innerjoin(E,Functions(i,:));
        for j = 1:nc
            C = innerjoin(F,Classes(j,:));
            bins(i,j) = height(C);
        end
    end
    
    FunctionNames = Functions.FunctionName;
    FunctionNames = clean_names(FunctionNames);
    ClassNames = Classes.Class;
    ClassNames = clean_names(ClassNames);
    Expression_Types = array2table(bins,...
        'RowNames',FunctionNames,...
        'VariableNames',ClassNames);
end

function A = clean_names(A)
    A = fill_empty_cells(A);
    A = replace_dot(A);
end

function A = fill_empty_cells(A)
    empty_cells = cellfun(@isempty,A);
    if any(empty_cells)
        A{empty_cells} = 'Unknown';
    end
end

function A = replace_dot(A)
    A = regexprep(A,'\.','_');
end
