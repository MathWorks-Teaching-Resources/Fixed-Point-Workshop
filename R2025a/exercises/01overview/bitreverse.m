function x = bitreverse(x,n0)
    n = int32(n0);
    nv2 = bitsra(n,1);
    j = int32(1);
    for i=1:(n-1)
        if i<j
            temp = x(j);
            x(j) = x(i);
            x(i) = temp;
        end
        k = nv2;
        while k<j
            j = j-k;
            k = bitsra(k,1);
        end
        j = j+k;
    end
end