function p = incrementCircularPointer(p,bufferLength)
    if ~isfloat(p) && log2(double(bufferLength))==floor(log2(double(bufferLength)))
        p(:) = bitand(p,cast(bufferLength-1,'like',p))+1;
    else
        p(:) = p + 1;
        if p > bufferLength
            p(:) = 1;
        end
    end
end