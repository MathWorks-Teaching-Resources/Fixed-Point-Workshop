function T = getStateTable
    
    % Copyright 2018 The MathWorks, Inc.
   
    numStates = coder.const(3);
    stateProto = fi([],0,nextpow2(numStates),0,hdlfimath);
    T.Idle = cast(0,'like',stateProto);
    T.Processing = cast(1,'like',stateProto);
    T.Done = cast(2,'like',stateProto);
    
end