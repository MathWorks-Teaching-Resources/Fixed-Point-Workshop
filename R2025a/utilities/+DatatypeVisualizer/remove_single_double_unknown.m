function E = remove_single_double_unknown(E)
        % Remove double, single, unknown types

%   Copyright 2022 The MathWorks, Inc.

    E = E(~(strcmp(E.Class,'double') | ...
            strcmp(E.Class,'single') | ...
            strcmp(E.Class,'')),:);
end
