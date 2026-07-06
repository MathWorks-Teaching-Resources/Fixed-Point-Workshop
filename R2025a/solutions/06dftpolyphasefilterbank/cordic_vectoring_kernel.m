function [x, y, z] = cordic_vectoring_kernel(x, y, z, a, N)
    assert(isscalar(x) && isscalar(y) && isscalar(z));
    if x<0
        % Compensation for 3rd and 4th quadrants
        x(:) = -x;
        y(:) = -y;
        angle_correction = cast(pi,'like',z);
    else
        angle_correction = cast(0,'like',z);
    end
    for n = 0:N-1
        xn = bitsra(x,n);
        yn = bitsra(y,n);
        if y < 0
            % Counter-clockwise rotation
            x(:) = x - yn;
            y(:) = y + xn;
            z(:) = z - a(n+1);
        else
            % Clockwise rotation
            x(:) = x + yn;
            y(:) = y - xn;
            z(:) = z + a(n+1);
        end
    end
    z(:) = z + angle_correction;
end

