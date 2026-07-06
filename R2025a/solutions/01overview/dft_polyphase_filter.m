function [magnitudeY, angleY] = dft_polyphase_filter(B,U,T)
    X = fir_filter_bank(B,U,T.fir_filter);
    Y = inverse_fft(X,T.fft,1);
    [magnitudeY, angleY] = cordic_cart2pol(Y);
end
