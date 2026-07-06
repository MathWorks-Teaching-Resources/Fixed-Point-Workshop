function S = resizeSVD(m,n,s,econFlag,matrixFlag)
    %resizeSVD  Resize singular value decomposition.
    %   S = fixed.internal.svd.s.resizeSVD(m,n,s,econFlag,matrixFlag)
    %   changes the size of the singular value decomposition U*diag(s)*V'
    %   corresponding to the econFlag and matrixFlag, where the number of rows
    %   of the original matrix is m and the number of columns is n.
    %
    %   If matrixFlag is true, then the singular values s are return in a
    %   diagonal matrix S.

    %   Copyright 2022 The MathWorks, Inc.
    %#codegen
    if m==0 || n==0
        S = emptyResize(m,n,s,econFlag,matrixFlag);
    else
        S = nonemptyResize(m,n,s,econFlag,matrixFlag);
    end

end

function S = emptyResize(m,n,s,econFlag,matrixFlag)
    if econFlag == 1
        % Economy size
        if matrixFlag
            S = zeros(0,'like',s);
        else
            S = zeros(0,1,'like',s);
        end
    else
        % Full size
        if matrixFlag
            S = zeros(m,n,'like',s);
        else
            S = zeros(0,1,'like',s);
        end
    end    
end

function S = nonemptyResize(m,n,s,econFlag,matrixFlag)
    s = sort(s,'descend');
    if econFlag == 1
        % Economy size
        if matrixFlag
            S = diag(s);
        else
            S = s;
        end
    else
        % Full size
        if matrixFlag
            S = [diag(s);zeros(m-n,n)];
        else
            S = s;
        end
    end
end