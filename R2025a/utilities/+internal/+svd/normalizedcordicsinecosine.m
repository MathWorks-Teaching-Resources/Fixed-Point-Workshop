function [sine,cosine] = normalizedcordicsinecosine(theta)
    %normalizedcordicsinecosine

    %   Copyright 2022 The MathWorks, Inc.
    %#codegen

    % theta quadrant correction
    % 1   == pi
    % 0.5 == pi/2
    % 2 == 2pi
    T = fixed.internal.svd.usv.cordicBidiagonalizationTypes(theta);
    theta = setfimath(theta,fixed.fimathLike(theta));
    piOver2 = cast(0.25,'like',theta);
    onePi = cast(0.5,'like',theta);
    twoPi = cast(1,'like',theta);
    thetaMinusOnePi = theta - onePi;
    thetaPlusOnePi  = theta + onePi;
    thetaMinusTwoPi = theta - twoPi;
    thetaPlusTwoPi  = theta + twoPi;
    needToNegate = false;
    if theta > piOver2
        % Convert an angle in range (pi/2 2*pi]
        %  to an angle in range [-pi/2 pi/2]:
        if (thetaMinusOnePi <= piOver2)
            % Need to subtract PI to get into [-pi/2 pi/2] range
            theta(:) = thetaMinusOnePi;
            needToNegate(:)   = true;
        else
            % Need to subtract 2*PI to get into [-pi/2 pi/2] range
            theta(:) = thetaMinusTwoPi;
        end

    elseif theta < -piOver2
        % Convert an angle in range [-2*pi -pi/2)
        %  to an angle in range [-pi/2 pi/2]:
        if (thetaPlusOnePi >= -piOver2)
            % Need to add PI to get into [-pi/2 pi/2] range
            theta(:) = thetaPlusOnePi;
            needToNegate(:)   = true;
        else
            % Need to add 2*PI to get into [-pi/2 pi/2] range
            theta(:) = thetaPlusTwoPi;
        end
    else
        % No quadrant correction necessary
        %theta(:) = theta;
    end

    [niter, Kn] = fixed.cordicConstants(theta);
    atan_table = fixed.internal.svd.normalizedCORDICAtanTable(niter,T.UV);

    x = cast(Kn,'like',theta);
    y = cast(0,'like',theta);
    z = theta;
    for i=0:niter-1
        x0 = x;
        if real(z)<0
            % Counter-clockwise rotation
            x(:) = x + bitsra(y, i);  % x -= y>>i
            y(:) = y - bitsra(x0,i);  % y += x0>>i
            z(:) = z + atan_table(i+1);
        else
            % Clockwise rotation
            x(:) = x - bitsra(y, i);  % x += y>>i
            y(:) = y + bitsra(x0,i);  % y += x0>>i
            z(:) = z - atan_table(i+1);
        end
    end
    if needToNegate
        cosine = -x;
        sine = -y;
    else
        cosine = x;
        sine = y;
    end
end
