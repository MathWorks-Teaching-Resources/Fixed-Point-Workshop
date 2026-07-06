function x = qlessQRMatrixSolve_hdl_wrapper(a,b,OutputType,m,n,p)
    % HDL code generation only supports vectors on the top-level interface
    A = reshape(a,m,n);
    B = reshape(b,n,p);
    X = fixed.qlessQRMatrixSolve(A,B,OutputType);
    x = X(:);
end