function w = radix2twiddles(n) 
    t = log2(n);
    if floor(t) ~= t
        error('N must be an exact power of two.');
    end

    w = complex(zeros(n-1,1));
    k=1;
    L=2;

    while L<=n
        theta = 2*pi/L;
        for j=0:(L/2 - 1)
            w(k) = complex( cos(j*theta), -sin(j*theta) );
            k = k + 1;
        end
        L = L*2;
    end
end