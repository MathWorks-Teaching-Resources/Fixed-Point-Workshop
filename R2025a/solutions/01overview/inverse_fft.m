function Y = inverse_fft(X, T, dim)
    M = size(X,1);
    w = cast(conj(radix2twiddles(M)),'like',T.w);
    X = cast(X,'like',T.x);
    Y = zeros(size(X),'like',T.x);
    if nargin < 3
        if isvector(X)
            Y = radix2fft_with_scaling(X,w);
        else
            dim = 1;
        end
    end
    switch dim
        case 1
            for j = 1:size(X,2)
                Y(:,j) = radix2fft_with_scaling(X(:,j), w);
            end
        case 2
            for i = 1:size(X,2)
                Y(i,:) = radix2fft_with_scaling(X(i,:), w);
            end
        otherwise
            error('Dimension argument must be 1 or 2')
    end
end