function X = jacobiMatrixRightUpdate(X,i,j,u)
    %jacobiMatrixRightUpdate

    %   Copyright 2022 The MathWorks, Inc.
    %#codegen

    % Update columns i and j
    % [X(:,i) X(:,j)] = [X(:,i) X(:,j)] * u
    %
    coder.inline('never')
    if isempty(X)
        X = removefimath(X);
    else
        u = removefimath(u);
        X = setfimath(X,fixed.fimathLike(X));
        x_i = X(:,i);
        x_j = X(:,j);
        X(:,i) = x_i*u(1,1) + x_j*u(2,1);
        X(:,j) = x_i*u(1,2) + x_j*u(2,2);
        X = removefimath(X);
    end
end