function [y,z,p] = fir_filter(b,x,z,p)
    y = zeros(size(x));
    for n=1:length(x)
        p = incrementCircularPointer(p,length(b));
        z(p) = x(n);
        acc = 0;
        k = p;
        for j = length(b):-1:1
            k = incrementCircularPointer(k,length(b));
            acc = acc + b(j)*z(k);
        end
        y(n) = acc;
    end
end

