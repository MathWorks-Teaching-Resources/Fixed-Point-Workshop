function [x_out,y_out,u_out,v_out] = cordicgivens(x_in,y_in,u_in,v_in,j,niter,Kn)
    %cordicgivens CORDIC Givens rotations for QR.
    %   [x,y,u,v] = cordicgivens(x,y,u,v,j,niter,Kn) performs Givens rotations
    %   to vectors x and y with j as the pivot and niter CORDIC
    %   iterations.  Kn is the inverse CORDIC gain factor.  The same
    %   Givens rotations are applied to u and v.

    %   Copyright 2020-2022 The MathWorks, Inc.
    %#codegen
    F_xy = fixed.fimathLike(x_in);
    F_uv = fixed.fimathLike(u_in);
    x = setfimath(x_in,F_xy);
    y = setfimath(y_in,F_xy);
    u = setfimath(u_in,F_uv);
    v = setfimath(v_in,F_uv);
    Kn = removefimath(Kn);
    % Rotate pivots to real.  This will only do work if they're not already
    % real.
    [x(:),u(:)] = fixed.qr.rotateFirstElementToReal(x,u,j,niter,Kn);
    [y(:),v(:)] = fixed.qr.rotateFirstElementToReal(y,v,j,niter,Kn);
    % Compensation for 3rd and 4th quadrants
    if real(x(j))<0
        x(:) = -x;
        y(:) = -y;
        u(:) = -u;
        v(:) = -v;
    end
    if real(y(j))~=0
        % Only do the CORDIC iterations if y(j) is not already zero
        for i=0:niter-1
            x0 = x;
            u0 = u;
            if real(y(j))<0
                % Counter-clockwise rotation
                u(:) = u - bitsra(v,i);
                v(:) = v + bitsra(u0,i);
                % Rotate over j:end
                for k = j:length(y)
                    x(k) = x(k) - bitsra(y(k), i);
                    y(k) = y(k) + bitsra(x0(k),i);
                end
            else
                % Clockwise rotation
                u(:) = u + bitsra(v,i);
                v(:) = v - bitsra(u0,i);
                % Rotate over j:end
                for k = j:length(y)
                    x(k) = x(k) + bitsra(y(k), i);
                    y(k) = y(k) - bitsra(x0(k),i);
                end
            end
        end
        % Set y(1) to exactly zero so R will be upper triangular
        % without roundoff showing up in the lower triangle.
        y(j) = 0;
        % Normalize the CORDIC gain
        x(:) = Kn * x;
        y(:) = Kn * y;
        u(:) = Kn * u;
        v(:) = Kn * v;
    end
    x_out = cast(x,'like',x_in);
    y_out = cast(y,'like',y_in);
    u_out = cast(u,'like',u_in);
    v_out = cast(v,'like',v_in);
end
