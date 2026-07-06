function [T,B,U,b,u,t,fs] = generate_inputs(M,N,n_out,datatypeselector,fidatatype,prototypevalue)
    if nargin<3
        n_out = 4000;
    end
    if nargin<4
        datatypeselector = 'double';
    end
    if nargin<5
        fidatatype = 'Fixed';
    end
    if nargin<6
        prototypevalue = 1i;
    end
    % FILTER COEFFICIENTS
    % Create the FIR Filter section of the Fixed-Point DFT Polyphase Filter Bank
    % Calculate the coefficients b for the prototype lowpass filter,
    % and zero-pad so that it has length M*N.
    Wn = 1/M; % Normalized frequency
    % Filter order M*N-1 means filter length is M*N
    b = fir1(M*N-1,Wn);
    B = reshape(b,M,N);
    
    %%
    n = M*n_out;
    fs = n;
    f1 = fs;
    f0 = 0;
    phi0 = 0;
    [u,t] = complex_linear_chirp(n,fs,f1,f0,phi0);
    
    %% DATA TYPES
    T = dft_polyphase_filter_types(datatypeselector,fidatatype,prototypevalue,max(abs(b)));

    u = cast(u,'like',T.fir_filter.x);
    U = flipud(reshape(u,M,length(u)/M));
    % Add initial delay
    U = [zeros(M,1), U(:,1:end-1)];
    
    B = cast(B,'like',T.fir_filter.coeff);
    U = cast(U,'like',T.fir_filter.x);
end
