%% (1) Inputs for test
[b0,x0,z0,t,tchirp] = fir_filter_inputs;
% Preserve the original floating-point values before overwriting later.
b = b0; 
x = x0;
z = z0;
p = 1;
%% (1) Builtin filter for comparison
y0 = filter(b,1,x);
fir_filter_plot1(t,tchirp,x,y0);

%% (5) Build instrumented mex
% T2 = fir_filter_dsp_types('ScaledDouble');
% b2 = cast(b,'like',T2.coefficient);
% x2 = cast(x,'like',T2.input);
% z2 = zeros(size(b),'like',T2.input);
% p2 = cast(1,'like',T2.index);
% buildInstrumentedMex fir_filter ...
%     -args {b2,x2,z2,p2,T2} -histogram -o instrumented_filter

%% (5) Run instrumented mex to find underflows and overflows
% [y2,z2,p2] = instrumented_filter(b2,x2,z2,p2,T2);

%% (2,4,5) Define types table
% T = fir_filter_double_types;
% % T = fir_filter_single_types;
% % T = fir_filter_dsp_types;

%% (3) Build MATLAB Executable (mex) in target types
% b = cast(b,'like',T.coefficient);
% x = cast(x,'like',T.input);
% z = zeros(size(b),'like',T.input);
% p = cast(1,'like',T.index);
% codegen fir_filter -args {b,x,z,p,T}

%% (1,2,3) Run
[y,z,p] = fir_filter(b,x,z,p);
% [y,z,p] = fir_filter(b,x,z,p,T);
% [y,z,p] = fir_filter_mex(b,x,z,p,T);


%% (1) Verify results
fir_filter_plot2(t,tchirp,x,y,y0);

%% (5) Visualize data types
% vis = VisualizeDatatypes('instrumented_filter',3, ...
%     '', '-proposeFL');

%% (3) C Code Generation
% Embedded devices never have the input over all time that is often
% simulated in MATLAB.
% Scalar input x elides the input/output for-loop.
% Vector input x is buffered, or frame input.
% codegen fir_filter -args {b,x(1:16),z,p,T} -config:lib -launchreport


