function r = qlessQR_hdl_wrapper(a,m,n)
    % HDL code generation only supports vectors on the top-level interface
    A = reshape(a,m,n);
    R = fixed.qlessQR(A);
    r = R(:);
end