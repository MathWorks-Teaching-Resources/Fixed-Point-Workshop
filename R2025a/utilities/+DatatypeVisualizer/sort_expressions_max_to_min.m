function S = sort_expressions_max_to_min(E)
% Datatype visualization beta.
    
%   Tom Bryan and Julia Wall, 5 April 2015
%   Copyright 2015-2022 The MathWorks, Inc.
    x = [E.SimMax E.SimMin];
    x = max(abs(x)');
    [~,I] = sort(x,'descend');
    S = E(I,:);
end
