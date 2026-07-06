function build_dft_polyphase_filter(B,U,T) %#ok<*INUSD>
    clear dft_polyphase_filter_mex
    codegen dft_polyphase_filter -args {B,U,T}
    rehash
    disp('Done building mex');
end