function v = euler_transform(phi, theta, psi, u, niters)
    
    % Copyright 2018 The MathWorks, Inc.
    Kn = 1/prod(sqrt(1 + 2.^(-2*(0:(double(niters)-1)))));
    angle_table = atan(2 .^ (-(0:(double(niters)-1))));
    
    [x, y] = cordic_rotation_kernel(u(2,:), u(3,:), phi, angle_table, niters);
    u(2,:) = x*Kn;
    u(3,:) = y*Kn;
    
    [x, y] = cordic_rotation_kernel(u(1,:), u(3,:), -theta, angle_table, niters);
    u(1,:) = x*Kn;
    u(3,:) = y*Kn;

    [x, y] = cordic_rotation_kernel(u(1,:), u(2,:), psi, angle_table, niters);
    u(1,:) = x*Kn;
    u(2,:) = y*Kn;
    
    v = u;
    
end

function [x, y, z] = cordic_rotation_kernel(x, y, z, angle_table, niters)
    [z, needToNegate] = fixed.internal.cordiccexpInputQuadrantCorrection(z(:), 1);
    x0 = x;
    y0 = y;
    for n = 1:niters
        if z < 0
            z(:) = z + angle_table(n);
            x(:) = x + y0;
            y(:) = y - x0;
        else
            z(:) = z - angle_table(n);
            x(:) = x - y0;
            y(:) = y + x0;
        end
        x0 = bitsra(x, n);
        y0 = bitsra(y, n);
    end
    if needToNegate
        x(:) = -x;
        y(:) = -y;
    end
end
