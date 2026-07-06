function X = fir_filter_bank(B,U,T)
% M = Number of channels in the filter bank.
% N = Number of taps in each FIR filter.

    M = size(U,1);
    N = size(B,2);
    P = zeros(M,1,'like',T.p);
    Z = zeros(M,N,'like',T.z);
    X = zeros(size(U),'like',T.y);
    for i = 1:M
        [X(i,:),Z(i,:),P(i)] = fir_filter_circular_buffer(B(i,:),U(i,:),Z(i,:),P(i),T);
    end

end
