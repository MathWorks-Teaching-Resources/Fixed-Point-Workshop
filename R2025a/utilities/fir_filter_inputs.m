function [b,x,z,t,tchirp] = fir_filter_inputs(M,N)
% Filter design
    if nargin == 0
        M = 4;  % Number of channels
        N = 8;  % Number of coefficients in each channel
    elseif nargin == 1
        N = 1;
    end
    Wn = 1/M; % Normalized frequency
    b = fir1(M*N-1,Wn);
    z = zeros(size(b));

    % Linear chirp input
    fs = 100; % Sampling frequency
    tchirp = (0:floor(pi*fs))'/fs; % Time vector
    f1 = fs/10; % Final frequency
    x_chirp = sin(pi*f1*tchirp.^2);  % Chirp
    
    % Signal that produces maximum output of FIR filter
    x_max_output = sign(fliplr(b))';
    x_max_output = repmat(x_max_output,3,1);

    x = [x_chirp; x_max_output];
    % Re-size t to include the max output signal
    t = (0:length(x)-1)'/fs;
end
