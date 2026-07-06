function [y,z] = fir_filter_linear_buffer(b,x,z)
    y = zeros(size(x));
    for n=1:length(x)
        z = [x(n), z(1:end-1)];
        y(n) = sum(b .* z);
    end
end
