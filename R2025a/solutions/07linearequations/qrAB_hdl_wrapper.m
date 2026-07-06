function [c,r] = qrAB_hdl_wrapper(a,b,m,n,p)
    % HDL code generation only supports vectors on the top-level interface
    A = reshape(a,m,n);
    B = reshape(b,m,p);
    [C,R] = fixed.qrAB(A,B);
    c = C(:);
    r = R(:);
end