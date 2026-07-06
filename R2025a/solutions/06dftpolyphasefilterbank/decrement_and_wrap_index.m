function p = decrement_and_wrap_index(m,n)
    if log2(double(n))==floor(log2(double(n)))
        % power of 2
        %% Lookup table
        %q = [n,1:n-1];
        %p = q(m);
        %% mod
        %p = mod(m-1+n-1,n)+1;
        p = mod(m+n-2,n)+1;
    else
        p = m - 1;
        if p < 1
            p(:) = n;
        end
    end
end
        
        