function  reciprocal = cordicReciprocalKernel(xIn)
%cordicReciprocalKernel Positive Real CORDIC Reciprocal Kernel
%
%   [reciprocal,t,validOut,x,y,z,validReg,tReg] = ...
%    cordicReciprocalKernel(xIn,t_in,validIn,x,y,z,validReg,tReg)
%
%   Given real scalar xIn such that 1 <= xIn < 2 this function produces
%   reciprocal such that
%
%      reciprocal = 1/xIn.
%
%   and reciprocal is in the range 0.5 < reciprocal <= 1.
%
%   When xIn = 0, then y = 2 - eps(y).
%
%   The input is only valid when validIn = true.  The output is only
%   valid when validOut = true.
%
%   The output t is identical to t_in, synchronized by validIn/validOut.
%
%   Variables x, y, z are the CORDIC iteration variables, passed back and
%   forth from the caller as persistent variables.
%
%   Variables validReg, tReg coordinate validIn/validOut and t_in/t
%   passed back and forth from the caller as persistent variables.
%
%   References:
%
%   [1] Jack E. Volder, "The CORDIC Trigonometric Computing Technique," IRE
%       Transactions on Electronic Computers, Volume EC-8, September 1959,
%       pp. 330-334.
%
%   [2] J.S. Walther, "A Unified Algorithm for Elementary Functions,"
%       Conference Proceedings, Spring Joint Computer Conference, May 1971,
%       pp. 379-385.

%   Copyright 2019 The MathWorks, Inc.
%#codegen
    [T,NumberOfCordicIterations] = fixed.internal.reciprocal.positiveReciprocalTypes(xIn);

    % At the end of the CORDIC iterations, z(end) = 1/xIn.
    x = cast(real(xIn),'like',T.x);
    y = cast(1,'like',T.x);
    z = cast(0,'like',T.x);

    % CORDIC reciprocal algorithm
    for k = 0:NumberOfCordicIterations
        x_shifted = bitsra(x, k);
        if y < 0
            y(:) = y + x_shifted;
            z(:) = z - bitsra(cast(1,'like',z), k);
        else
            y(:) = y - x_shifted;
            z(:) = z + bitsra(cast(1,'like',z), k);
        end
    end
    reciprocal = cast(z,'like',T.output);
end
