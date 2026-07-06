function E = remove_single_double_unknown_integer(E)
        % Remove double, single, unknown types

%   Copyright 2022 The MathWorks, Inc.

    E = E(~(strcmp(E.Class,'double') | ...
            strcmp(E.Class,'single') | ...
            strncmp(E.Class,'int',3)),:);
end
