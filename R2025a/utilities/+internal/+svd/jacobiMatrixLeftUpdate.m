function X = jacobiMatrixLeftUpdate(X,i,j,u)
    %jacobiMatrixLeftUpdate

    %   Copyright 2022 The MathWorks, Inc.
    %#codegen

    % Update rows i and j 
    % [X(i,:)  = u' * [X(i,:)
    %  X(j,:)]         X(j,:)]
    coder.inline('never')
    if isempty(X)
        X = removefimath(X);
    else
        u = removefimath(u');
        X = setfimath(X,fixed.fimathLike(X));
        x_i = X(i,:);
        x_j = X(j,:);
        X(i,:) = u(1,1)*x_i + u(1,2)*x_j;
        X(j,:) = u(2,1)*x_i + u(2,2)*x_j;
        X = removefimath(X);
    end
end