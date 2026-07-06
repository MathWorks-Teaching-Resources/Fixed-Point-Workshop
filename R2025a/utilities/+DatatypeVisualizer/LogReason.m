classdef LogReason < int32
% Datatype visualization beta.
    
%   Tom Bryan and Julia Wall, 5 April 2015
%   Copyright 2015 The MathWorks, Inc.

    enumeration
        UNKNOWN   (0)
        ARGIN     (1)
        ASSIGN    (2)
        CALL      (3)
        MULTICALL (4)
        ADD       (5)
        SUBTRACT  (6)
        MULTIPLY  (7)
        DIVIDE    (8)
        FORINDEX  (9)
        CPPSYSOBJ (10)
    end
    
end
