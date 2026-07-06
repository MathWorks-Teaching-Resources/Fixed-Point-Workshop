function p = increment_and_wrap_index(m,n)
    if log2(double(n))==floor(log2(double(n)))
        % power of 2
        p = bitand(m,cast(n,'like',m)-1)+1;
    else
        p = m + 1;
        if p > n
            p(:) = 1;
        end
    end
end
        
        