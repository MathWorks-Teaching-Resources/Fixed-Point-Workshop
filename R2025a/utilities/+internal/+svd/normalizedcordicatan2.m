function theta = normalizedcordicatan2(y,x)
    %normalizedcordicatan2

    %   Copyright 2022 The MathWorks, Inc.
    %#codegen
    T = fixed.internal.svd.usv.cordicBidiagonalizationTypes(y);
    niter = fixed.cordicConstants(y);
    atan_table = fixed.internal.svd.normalizedCORDICAtanTable(niter,T.UV);
    x_quad_adjust = false;
    y_quad_adjust = false;
    z = cast(0,'like',T.UV);
    x = setfimath(x,fixed.fimathLike(x));
    y = setfimath(y,fixed.fimathLike(x));
    z = setfimath(z,fixed.fimathLike(z));
    % Compensation left half plane
    if real(x)<0
        x(:) = -x;
        x_quad_adjust = true;
    end
    % Compensation for lower half plane
    if real(y)<0
        y(:) = -y;
        y_quad_adjust = true;
    end
    for i=0:niter-1
        x0 = x;
        if real(y)<0
            % Counter-clockwise rotation
            x(:) = x - bitsra(y, i);  % x -= y>>i
            y(:) = y + bitsra(x0,i);  % y += x0>>i
            z(:) = z - atan_table(i+1);
        else
            % Clockwise rotation
            x(:) = x + bitsra(y, i);  % x += y>>i
            y(:) = y - bitsra(x0,i);  % y += x0>>i
            z(:) = z + atan_table(i+1);
        end
    end
    theta = cast(0,'like',z);
    onePi = cast(0.5,'like',theta); % 1/2 is congruent to pi
    if x_quad_adjust
        if y_quad_adjust
            theta(:) = z - onePi;  
        else
            theta(:) = onePi - z;
        end
    else
        if y_quad_adjust
            theta(:) = -z;
        else
            theta(:) = z;
        end
    end
    theta = removefimath(theta);
end
