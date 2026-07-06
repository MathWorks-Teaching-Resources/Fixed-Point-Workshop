function X = matrixSolveModelOutputToArray(X_out,n,p,numSamples)
%matrixSolveModelOutputToArray Matrix solve model output to array
%   X = fixed.example.matrixSolveModelOutputToArray(X_out,n,p,numSamples)
%   re-orders the elements of the Simulink model output for AX=B
%   matrix solve blocks to an array, where X_out is the logged output
%   of the Simulink model, n is the number of columns in A, p is the
%   number of columns in B, and numSamples is the number of samples of
%   A and B in the simulation.
%
%   The matrix solve blocks output the solution X of AX=B by row in
%   order of computation.  Since X is computed by back-substitution,
%   the Simulink model outputs the last row of X first and the first
%   row of X last.  This function rearranges the Simulink output into
%   the natural order with the first row first, and the last row last.

%   Copyright 2021-2022 The MathWorks, Inc.
    if nargin<4
        numSamples = 1;
    end
    X = zeros(n,p,numSamples,'like',X_out);
    for k = 1:numSamples
        for i = 1:n
            j = i + (k-1)*n;
            X(i,:,k) = X_out(:,:,j);
        end
    end
    %     end
    X = squeeze(X);
end