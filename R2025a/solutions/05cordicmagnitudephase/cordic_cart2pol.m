function [magnitudeZ, angleZ] = cordic_cart2pol(Z)
    [T,N,a] = cordic_magnitude_angle_types(real(Z(1)));
    Kn = inverse_cordic_growth_constant(N);
    magnitudeZ = zeros(size(Z),'like',T.x);
    angleZ = zeros(size(Z),'like',T.theta);
    for i = 1:numel(Z)
        x = cast(real(Z(i)),'like',T.x);
        y = cast(imag(Z(i)),'like',T.y);
        theta = zeros(1,'like',T.theta);
        [magnitudeZ(i), ~, angleZ(i)] = cordic_vectoring_kernel(x, y, theta, N, a);
        magnitudeZ(i) = magnitudeZ(i) * Kn;
    end
    magnitudeZ = removefimath(magnitudeZ);
    angleZ = removefimath(angleZ);
end
