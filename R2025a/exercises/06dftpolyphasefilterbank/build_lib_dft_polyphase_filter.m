function build_lib_dft_polyphase_filter(B,U,T) %#ok<*INUSD>
    cfg = coder.config('lib');
    % Report
    cfg.GenerateReport = true;
    cfg.LaunchReport = false;
    % Turn off builtin integer saturation
    cfg.SaturateOnIntegerOverflow = false;
    % Comment control
    cfg.GenerateComments = false;
    cfg.MATLABFcnDesc = false;
    cfg.MATLABSourceComments = false;
    cfg.Verbose = false;
    codegen dft_polyphase_filter -args {B,U(:,1),T} -config cfg
    clear dft_polyphase_filter_mex
    rehash
    disp('Done building lib')
end