function [x, y, theta] = cordic_vectoring_kernel(x, y, theta, N, a)
    assert(isscalar(x) && isscalar(y) && isscalar(theta));
    if x<0
        % Reflect into the right half-plane
        x(:) = -x;
        y(:) = -y;
        angle_correction = cast(pi,'like',theta);
    else
        angle_correction = cast(0,'like',theta);
    end
    for n = 0:N-1
        x_shifted = bitsra(x,n);
        y_shifted = bitsra(y,n);
        if y < 0
            % Counterclockwise rotation
            x(:) = x - y_shifted;
            y(:) = y + x_shifted;
            theta(:) = theta - a(n+1);
        else
            % Clockwise rotation
            x(:) = x + y_shifted;
            y(:) = y - x_shifted;
            theta(:) = theta + a(n+1);
        end
    end
    theta(:) = theta + angle_correction;
end