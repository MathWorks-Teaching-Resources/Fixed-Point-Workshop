function [u,t] = complex_linear_chirp(n,fs,f1,f0,phi0)
    % n = number of samples in the chirp
    % fs = sample frequency in Hz
    % f0 = initial frequency in Hz
    % f1 = final frequency in Hz
    % ph0 = initial phase in radians
    t = (0:n-1)/fs;
    phi = pi*f1*t.^2 + 2*pi*f0*t + phi0;
    u = exp(1i*phi);
end