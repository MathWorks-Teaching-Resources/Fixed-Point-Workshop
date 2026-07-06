function An = cordic_growth_constant(N)
    % CORDIC_GROWTH_CONSTANT(N) returns the CORDIC growth factor An after N
    % iterations. The cordic growth constant An quickly converges to around
    % 1.6468.
    if nargin<1
        N = 52;
    end
    An = prod(sqrt(1+2.^(-2*(0:double(N)-1))));
end
