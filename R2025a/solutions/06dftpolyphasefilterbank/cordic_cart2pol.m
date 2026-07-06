function [magnitudeZ, angleZ] = cordic_cart2pol(Z)
    [T,N,a] = cordic_magnitude_angle_types(real(Z(1)));
    Kn = inverse_cordic_growth_constant(N);
    magnitudeZ = zeros(size(Z),'like',T.x);
    angleZ = zeros(size(Z),'like',T.z);
    for i = 1:numel(Z)
        x = cast(real(Z(i)),'like',T.x);
        y = cast(imag(Z(i)),'like',T.y);
        z = zeros(1,'like',T.z);
        [magnitudeZ(i), ~, angleZ(i)] = cordic_vectoring_kernel(x, y, z, N, a);
        magnitudeZ(i) = magnitudeZ(i) * Kn;
    end
    magnitudeZ = removefimath(magnitudeZ);
    angleZ = removefimath(angleZ);
end

function [x, y, z] = cordic_vectoring_kernel(x, y, z, N, a)
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

function a = cordic_angular_increments(N)
    a = atan(2 .^ -(0:N-1)');
end

function Kn = inverse_cordic_growth_constant(N)
    % Kn = INVERSE_CORDIC_GROWTH_CONSTANT(N) returns the inverse of the
    % CORDIC growth factor after N iterations. The inverse cordic growth
    % constant Kn quickly converges to around 0.60725.
    Kn = 1/cordic_growth_constant(N);
end

function An = cordic_growth_constant(N)
    % CORDIC_GROWTH_CONSTANT(N) returns the CORDIC growth factor after N
    % iterations. The cordic growth constant quickly converges to around
    % 1.6468.
    An = prod(sqrt(1+2.^(-2*(0:double(N)-1))));
end

function [T,N,a] = cordic_magnitude_angle_types(t)
    if isfi(t)
        datatype = t.DataType;
        w = t.WordLength;
        N = w - 1;
        f = t.FractionLength;
        F_xy = fimath('RoundingMethod', 'Floor', ...
            'OverflowAction', 'Wrap',...
            'SumMode','SpecifyPrecision',...
            'SumWordLength',w,...
            'SumFractionLength',w-3);
        F_t = fimath('RoundingMethod', 'Floor', ...
            'OverflowAction', 'Wrap',...
            'SumMode','SpecifyPrecision',...
            'SumWordLength',w,...
            'SumFractionLength',f-2);
        F_z = fimath('RoundingMethod', 'Floor', ...
            'OverflowAction', 'Wrap',...
            'SumMode','SpecifyPrecision',...
            'SumWordLength',w,...
            'SumFractionLength',w-4);
        T.a = fi([],0,w,w-1,'DataType',datatype);
        T.t = fi([],1,w,f-2,F_t,'DataType',datatype);
        T.x = fi([],1,w,w-3,F_xy,'DataType',datatype);
        T.y = fi([],1,w,w-3,F_xy,'DataType',datatype);
        T.z = fi([],1,w,w-4,F_z,'DataType',datatype);
    else
        N = 52;
        T.a = cast([],'like',t);
        T.t = cast([],'like',t);
        T.x = cast([],'like',t);
        T.y = cast([],'like',t);
        T.z = cast([],'like',t);
    end
    a = cast(cordic_angular_increments(N),'like',T.a);
end