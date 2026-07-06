function build_instrumented_dft_polyphase_filter(B,U,T) %#ok<*INUSD>
    clear dft_polyphase_filter_instrumented
    buildInstrumentedMex dft_polyphase_filter -args {B,U,T} -o dft_polyphase_filter_instrumented -histogram
    rehash
    disp('Done building instrumented mex')
end