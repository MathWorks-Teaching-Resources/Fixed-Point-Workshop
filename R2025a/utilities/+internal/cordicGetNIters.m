function nIters = cordicGetNIters(xIn)%#codegen
% cordicGetNIters Get number of iterations for CORDIC

% Copyright 2022 The MathWorks, Inc.

   if isfi(xIn) && isfixed(xIn)
       % It does not make sense to iterate beyond T.WordLength - 1, as all
       % of the bit shifts zero out beyond this point.
       nIters = xIn.WordLength - 1;
   elseif isa(xIn, 'single') || (isfi(xIn) && issingle(xIn))
       nIters = 25;
   elseif isa(xIn, 'double') || (isfi(xIn) && isdouble(xIn))
       nIters = 54;
   else
       % Integer
       fiInt = fi(xIn);
       nIters = fiInt.WordLength - 1;
   end

end