function [C,R] = qrModelOutputToArray(C_out,R_out,m,n,p,numSamples)
%qrModelOutputToArray QR model output to array
%   [C,R] = fixed.example.qrModelOutputToArray(C_out,R_out,m,n,p,numSamples)
%   re-orders the elements of the Simulink model output for the QR
%   factorization to an array, where C_out and R_out are the logged
%   outputs of the Simulink model, m is the number of rows in A and B,
%   n is the number of columns in A, p is the number of columns in B,
%   and numSamples is the number of samples of A and B in the
%   simulation.
%
%   The QR blocks output C and R by row in order of computation.  The
%   Simulink model outputs the last row of C and R first and the first
%   row of C and R last.  This function rearranges the Simulink output
%   into the natural order with the first row first, and the last row
%   last.

%   Copyright 2021-2022 The MathWorks, Inc.
    R = fixed.example.qlessqrModelOutputToArray(R_out,m,n,numSamples);
    if isvector(C_out)
        C = flipud(C_out);
    else
        mn = min(m,n);
        C = zeros(mn,p,numSamples,'like',C_out);
        for k = 1:numSamples
            for i = 1:mn
                j = (mn-i+1) + (k-1)*mn;
                C(i,:,k) = C_out(:,:,j);
            end
        end
        if numSamples==1
            C = squeeze(C);
        end
    end
end
