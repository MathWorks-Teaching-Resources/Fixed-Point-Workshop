function [x, y, z] = cordicRotationKernelIter(xIn, yIn, zIn, iter, inputLUT)%#codegen
%% cordicRotationKernelIter Perform one iteration of a CORDIC rotation
%   [x, y, z] = fixed.internal.cordicRotationKernelIter(xIn, yIn, zIn,
%   iter, inputLUT) performs one iteration of the CORDIC rotation of the
%   vector [xIn, yIn] by angle zIn.
%
%   Inputs:
%       xIn is the x component of the input vector. It is any fixed-point
%       or numeric type.
%
%       yIn is the y component of the input vector. It is any fixed-point
%       or numeric type.
%
%       zIn is the angle to rotate by. It is any fixed-point or numeric
%       type.
%
%       iter is the number of the iteration in the CORDIC rotation. It must
%       be an integer less than the number of entries in inputLUT. It is
%       any fixed-point or numeric type.
%
%       inputLUT is the lookup table of a angles used to update z in each
%       iteration. It is any fixed-point or numeric type, though its
%       addition with z must be defined.
%
%  Outputs:
%       x is the value of the x element of the rotated vector after
%       iteration iter. It has the same type as xIn.
%
%       y is the value of the y element of the rotated vector after
%       iteration iter. It has the same type as yIn.
%
%       z is the value of the angle z after iteration iter. It has the same
%       type as zIn.

% Copyright 2022 The MathWorks, Inc.

coder.inline('always');

x = cast(0, 'like', xIn);
y = cast(0, 'like', yIn);
z = cast(0, 'like', zIn);
xTmp = bitsra(xIn, iter);
yTmp = bitsra(yIn, iter);
if zIn < 0
    x(:) = xIn + yTmp;
    y(:) = yIn - xTmp;
    z(:) = zIn + inputLUT(iter + 1);
else
    x(:) = xIn - yTmp;
    y(:) = yIn + xTmp;
    z(:) = zIn - inputLUT(iter + 1);
end


end