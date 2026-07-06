function [x_out,y_out] = cordicgivens(x_in,y_in,j,niter,Kn)
    %cordicgivens CORDIC Givens rotations for Q-less QR.
    %   [x,y] = cordicgivens(x,y,j,niter,Kn) performs Givens rotations
    %   to vectors x and y with j as the pivot and niter CORDIC
    %   iterations.  Kn is the inverse CORDIC gain factor.

    %   Copyright 2020-2022 The MathWorks, Inc.
    %#codegen
    F = fixed.fimathLike(x_in);
    x = setfimath(x_in,F);
    y = setfimath(y_in,F);
    Kn = removefimath(Kn);
    % Rotate pivots to real.  This will only do work if they're not already
    % real.
    x(:) = fixed.qlessqr.rotateFirstElementToReal(x,j,niter,Kn);
    y(:) = fixed.qlessqr.rotateFirstElementToReal(y,j,niter,Kn);
    % Compensation for 3rd and 4th quadrants
    if real(x(j))<0
        x(:) = -x;
        y(:) = -y;
    end
    if real(y(j))~=0
        % Only do the CORDIC iterations if y(j) is not already zero
        for i=0:niter-1
            x0 = x;
            if real(y(j))<0
                % Counter-clockwise rotation
                % x and y form R
                % Rotate over j:end
                for k = j:length(y)
                    x(k) = x(k) - bitsra(y(k), i);  % x -= y>>i
                    y(k) = y(k) + bitsra(x0(k),i);  % y += x0>>i
                end
            else
                % Clockwise rotation
                % x and y form R
                % Rotate over j:end
                for k = j:length(y)
                    x(k) = x(k) + bitsra(y(k), i);  % x += y>>i
                    y(k) = y(k) - bitsra(x0(k),i);  % y += x0>>i
                end
            end
        end
        % Set y(1) to exactly zero so R will be upper triangular
        % without roundoff showing up in the lower triangle.
        y(j) = 0;
        % Normalize the CORDIC gain
        x(:) = Kn * x;
        y(:) = Kn * y;
    end
    x_out = cast(x,'like',x_in);
    y_out = cast(y,'like',y_in);
end
