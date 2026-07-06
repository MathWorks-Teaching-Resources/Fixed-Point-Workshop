%% Test MATLAB Function Block
% 
%% Inputs for test
[b0,x0,z0,t,tchirp] = fir_filter_inputs;
% Preserve the original floating-point values before overwriting later.
b = b0; 
x = x0;
z = z0;
p = 1;
%% Builtin filter for comparison
y0 = filter(b,1,x);
fir_filter_plot1(t,tchirp,x,y0);

%% Define types table
% Uncomment the types table you want to use.
% T = fir_filter_double_types;
% T = fir_filter_single_types;
T = fir_filter_dsp_types;

%% Cast input to selected types 
b = cast(b0,'like',T.coefficient);
x = cast(x0,'like',T.input);

%% Assignin variables to the model workspace
% Putting the variables in the model workspace allows you to run the model
% standalone.  The variables could also be left in the MATLAB workspace.
% https://www.mathworks.com/help/simulink/slref/simulink.modelworkspace.html
model = 'fir_filter_model';
open_system(model)
mdlWks = get_param(model,'ModelWorkspace');
assignin(mdlWks,'x',x);
assignin(mdlWks,'b',b);
assignin(mdlWks,'T',T);

out = sim(model);
%% Compare the output of the model with builtin MATLAB
fir_filter_plot2(t,tchirp,x,out.y,y0);


