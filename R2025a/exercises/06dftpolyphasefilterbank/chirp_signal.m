function [u,t] = chirp_signal(n,fs,f0)
% n = number of samples in the chirp
% fs = sampling frequency
% f0 = target frequency for the chirp
    
    t = (0:n-1)/fs;
    u = sin(pi*f0*t.^2);  % Linear chirp

end