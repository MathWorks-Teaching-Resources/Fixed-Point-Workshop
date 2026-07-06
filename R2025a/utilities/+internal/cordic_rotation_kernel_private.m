function [x, y, z] = cordic_rotation_kernel_private(x, y, z, inpLUT, niters)
% CORDIC_ROTATION_KERNEL_PRIVATE Perform CORDIC rotation mode iterations.

% Copyright 2009-2022 The MathWorks, Inc.

%#codegen

coder.allowpcode('plain');

if ~isempty(coder.target)
    eml_prefer_const(inpLUT, niters);
end

xtmp = x;
ytmp = y;
for idx = 1:niters
    if z < 0
        x(:) = x + ytmp;
        y(:) = y - xtmp;
        z(:) = z + inpLUT(idx);
    else
        x(:) = x - ytmp;
        y(:) = y + xtmp;
        z(:) = z - inpLUT(idx);
    end
    xtmp = bitsra(x, idx);
    ytmp = bitsra(y, idx);
end
