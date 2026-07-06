function Kn = inverse_cordic_growth_constant(N)
    % Kn = INVERSE_CORDIC_GROWTH_CONSTANT(N) returns the inverse of the
    % CORDIC growth factor after N iterations. The inverse cordic growth
    % constant Kn quickly converges to around 0.60725.
    Kn = 1/cordic_growth_constant(N);
end
