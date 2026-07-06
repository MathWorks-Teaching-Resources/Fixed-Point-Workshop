function [C,R] = qrABSimplified(A,B)
    
    [niter, Kn] = fixed.cordicConstants(A);
    [m,n] = size(A);
    p = size(B,2);
    C = zeros(n,p,'like',B);
    R = zeros(n,n,'like',A);
    for i = 1:m
        for j = 1:n
            if ~isreal(A(i,:))
                [A(i,:),B(i,:)] = fixed.qr.rotateFirstElementToReal(A(i,:),B(i,:),j,niter,Kn);
                % Set a breakpoint on the following line and watch the
                % leading element of A rotating to real.
            end
            [R(j,:),A(i,:),C(j,:),B(i,:)] = fixed.qr.cordicgivens(R(j,:),A(i,:),C(j,:),B(i,:),j,niter,Kn);
            % Set a breakpoint on the following line, open R and A in the
            % MATLAB Workspace viewer, and watch their progress as they are
            % computed.
        end
    end
end

