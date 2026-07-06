function R = qlessqrModelOutputToArray(R_out,m,n,numSamples)
%qlessqrModelOutputToArray Q-less QR model output to array
%   R = fixed.example.qlessqrModelOutputToArray(R_out,m,n,numSamples)
%   re-orders the elements of the Simulink model output for the Q-less
%   QR factorization to an array, where R_out is the logged output of
%   the Simulink model, m is the number of rows in A, n is the number
%   of columns in A, and numSamples is the number of samples of A in
%   the simulation.
%
%   The Q-less QR blocks output R by row in order of computation.  The
%   Simulink model outputs the last row of R first and the first row
%   of R last.  This function rearranges the Simulink output into the
%   natural order with the first row first, and the last row last.

%   Copyright 2021-2022 The MathWorks, Inc.
    if nargin<4
        numSamples = 1;
    end
    R = zeros(min(m,n),n,numSamples,'like',R_out);
    mn = min(m,n);
    for k = 1:numSamples
        for i = 1:mn
            j = (mn-i+1) + (k-1)*mn;
            R(i,:,k) = R_out(:,:,j);
        end
    end
    if numSamples==1
        R = squeeze(R);
    end
end
