function [y,z,p] = fir_filter(b,x,z,p,T)
    y = zeros(size(x),'like',T.output);
    for n=1:length(x)
        p = incrementCircularPointer(p,length(b));
        z(p) = x(n);
        acc = cast(0,'like',T.sum);
        k = p;
        for j = length(b):-1:1
            k = incrementCircularPointer(k,length(b));
            acc(:) = acc + b(j)*z(k);
        end
        y(n) = acc;
    end
end

