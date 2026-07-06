function An = cordic_growth_constant(N)
    % CORDIC_GROWTH_CONSTANT(N) returns the CORDIC growth factor after N
    % iterations. The cordic growth constant quickly converges to around
    % 1.6468.
    An = prod(sqrt(1+2.^(-2*(0:double(N)-1))));
end