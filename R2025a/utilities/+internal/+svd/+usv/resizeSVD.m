function [U,S,V] = resizeSVD(m,n,U,s,V,econFlag,matrixFlag)
    %resizeSVD  Resize singular value decomposition.
    %   [U,S,V] = fixed.internal.svd.usv.resizeSVD(m,n,U,s,V,econFlag,matrixFlag)
    %   changes the size of the singular value decomposition U*diag(s)*V'
    %   corresponding to the econFlag and matrixFlag, where the number of rows
    %   of the original matrix is m and the number of columns is n.
    %
    %   If econFlag is true, then only the first n columns of U are returned.
    %
    %   If matrixFlag is true, then the singular values s are return in a
    %   diagonal matrix S.

    %   Copyright 2022 The MathWorks, Inc.
    %#codegen
    if m==0 || n==0
        [U,S,V] = emptyResize(m,n,U,s,V,econFlag,matrixFlag);
    else
        [U,S,V] = nonemptyResize(m,n,U,s,V,econFlag,matrixFlag);
    end

end

function [U,S,V] = emptyResize(m,n,U,s,V,econFlag,matrixFlag)
    % Builtin svd has special rules for the sizes of the outputs when the
    % matrix is empty.
    if econFlag == 1
        U = eye(m,n,'like',U);
        V = eye(n,n,'like',V);
        % Economy size
        if matrixFlag
            S = zeros(0,'like',s);
        else
            S = zeros(0,1,'like',s);
        end
    else
        U = eye(m,'like',U);
        V = eye(n,'like',V);
        % Full size
        if matrixFlag
            S = zeros(m,n,'like',s);
        else
            S = zeros(0,1,'like',s);
        end
    end    
end

function [U,S,V] = nonemptyResize(m,n,U,s,V,econFlag,matrixFlag)
    [s,svd_index] = sort(s,'descend');
    if econFlag == 1
        % Economy size
        % Permute the first n columns of the left and right singular
        % vectors to match the sorted
        % singular values.  These columns correspond to the range of A. Only keep these singular vectors.
        U = U(:,svd_index);
        V = V(:,svd_index);
        if matrixFlag
            S = diag(s);
        else
            S = s;
        end
    else
        % Full size
        % Permute the first n columns of the left and right singular
        % vectors that correspond to the range of A to match the sorted
        % singular values. These columns correspond to the range of A.
        % Append the remaining singular vectors.  The remaining singular
        % vectors correspond to the null space of A.
        U = [U(:,svd_index),U(:,n+1:end)];
        V = [V(:,svd_index),V(:,n+1:end)];
        if matrixFlag
            S = [diag(s);zeros(m-n,n)];
        else
            S = s;
        end
    end
end