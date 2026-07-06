function [E,Expression_Types] = get_fi_types(E) 
% Datatype visualization beta.
    
%   Tom Bryan and Julia Wall, 5 April 2015
%   Copyright 2015-2022 The MathWorks, Inc.

    
    Functions = unique(E(:,'FunctionName'));
    nf = height(Functions);

    E = E(strcmp(E.Class,'embedded.fi'),:);

    DataTypes = unique(E(:,'DataType'));
    nc = height(DataTypes);

    
    bins = zeros(nf,nc);

    for i = 1:nf
        F = innerjoin(E,Functions(i,:));
        for j = 1:nc
            C = innerjoin(F,DataTypes(j,:));
            bins(i,j) = height(C);
        end
    end
    
    FunctionNames = Functions.FunctionName;
    FunctionNames = clean_names(FunctionNames);
    DataTypeNames = DataTypes.DataType;
    DataTypeNames = clean_names(DataTypeNames);
    Expression_Types = array2table(bins,...
        'RowNames',FunctionNames,...
        'VariableNames',DataTypeNames);
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
    for n = 1:length(A)
        A{n} = regexprep(A{n},'\.','_');
    end
    % 
%     A = cellfun(@dot_replacer,A);
%     function str = dot_replacer(str)
%         str = regexprep(str,'\.','_');
%     end
end
