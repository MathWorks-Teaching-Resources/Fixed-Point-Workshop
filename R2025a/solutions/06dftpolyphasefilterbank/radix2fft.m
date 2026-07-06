function x = radix2fft(x, w)
    n = length(x);
    t = log2(n);
    x = bitreverse(x,n);
    LL = int32(2.^(1:t));
    rr = int32(n./LL);
    LL2 = int32(LL./2);
    for q=1:t
        L = LL(q); r = rr(q); L2 = LL2(q);
        for k=0:(r-1)
            % Skip multiply by w^0=1
            x0          = x(k*L+L2+1);
            x(k*L+L2+1) = x(k*L+1) - x0;
            x(k*L+1)    = x(k*L+1) + x0;
            for j=1:(L2-1)
                x0            = w(L2-1+j+1) * x(k*L+j+L2+1);
                x(k*L+j+L2+1) = x(k*L+j+1) - x0;
                x(k*L+j+1)    = x(k*L+j+1) + x0;
            end
        end
    end
end
