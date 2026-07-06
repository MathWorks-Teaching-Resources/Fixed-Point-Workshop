%% Generate inputs
M = 32; % Number of channels in the filter bank.
N = 8;  % Number of taps in each FIR filter.
n_out = 4000; % Number of outputs at each output of the filter bank
datatypeselector = 'hdl'; % 'double' 'single' 'hdl' 'dsp'
fidatatype = 'Fixed';
prototypevalue = 1i;
[T,B,U,b,u,t,fs] = generate_inputs(M,N,n_out,datatypeselector,fidatatype,prototypevalue);


%% Build and run in target type
build_dft_polyphase_filter(B,U,T);
[absY, angleY] = dft_polyphase_filter_mex(B,U,T);

%% Build and run instrumented in scaled double types
fidatatype = 'ScaledDouble';
[T2,B2,U2] = generate_inputs(M,N,n_out,datatypeselector,fidatatype,prototypevalue);
build_instrumented_dft_polyphase_filter(B2,U2,T2);
%%
[absY2,angleY2] = dft_polyphase_filter_instrumented(B2,U2,T2);

%% Plot
%plot_one_channel_at_a_time(M ,fs,absY,1)
%%
t2 = plot_dft_polyphase_filter_outputs(M,fs,absY,angleY,1);
%%
plot_dft_polyphase_filter_errors(M,fs,absY,angleY,absY2,angleY2,2);

%% Visualize datatypes
% Function to focus on.  Empty for all functions
% fun = 'fir_filter_circular_buffer';
fun = '';
vis = VisualizeDatatypes('dft_polyphase_filter_instrumented',3,fun);
