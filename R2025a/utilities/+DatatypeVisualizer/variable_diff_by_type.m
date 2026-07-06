function [D1,D2] = variable_diff_by_type(V1,V2)
%

%   Copyright 2022 The MathWorks, Inc.

    intersect_fields = {
        'ScriptPath'
        'FunctionName'
        'Size'
        'LineNumber'
        'Expression'
        };
    
    [Intersection,I1,I2] = intersect(V1(:,intersect_fields),V2(:,intersect_fields)); %#ok<ASGLU>
    Diff_index = zeros(size(I1));
    for n = 1:length(I1)
        P1 = V1.Prototype(I1(n));
        if isempty(P1)
            P1 = [];
        else
            P1 = P1{1};
        end
        P2 = V2.Prototype(I2(n));
        if isempty(P2)
            P2 = [];
        else
            P2 = P2{1};
        end
        if ~local_isequivalent_type(P1,P2)
            Diff_index(n) = n;
        end
    end
    Diff_index(Diff_index==0) = [];
    D1 = V1(I1(Diff_index),:);
    D2 = V2(I2(Diff_index),:);
end

function t = local_isequivalent_type(a,b)
    if isfi(a) && isfi(b)
        %a.numerictype.WordLength < b.numerictype.WordLength; % find the change that's bigger
        t = isequivalent(a.numerictype,b.numerictype);% && ...
            %isequal(a.fimath,b.fimath);
    else
        t = isequal(class(a),class(b));
    end
end

        
