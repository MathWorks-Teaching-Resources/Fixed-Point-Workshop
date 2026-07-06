function x = qrMatrixSolve_hdl_wrapper(a,b,OutputType,m,n,p)
    % HDL code generation only supports vectors on the top-level interface
    A = reshape(a,m,n);
    B = reshape(b,m,p);
    X = fixed.qrMatrixSolve(A,B,OutputType);
    x = X(:);
end