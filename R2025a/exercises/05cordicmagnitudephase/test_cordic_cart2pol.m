%% test_cordic_cart2pol
theta = linspace(0,2*pi,1000);
Z0 = 2*exp(1i*theta);
% Run MATLAB code in fixed-point
Z = fi(Z0,1,16,'DataType','Fixed');
codegen cordic_cart2pol -args {Z}
[magnitudeZ, angleZ] = cordic_cart2pol_mex(Z);
% Run instrumented mex file
Z1 = fi(Z0,1,16,'DataType','ScaledDouble');
buildInstrumentedMex cordic_cart2pol -args {Z1} -histogram -o cordic_cart2pol_instrumented
cordic_cart2pol_instrumented(Z1);

%% Plot
figure(1)
clf
subplot(2,1,1)
plot(theta,magnitudeZ,theta,abs(double(Z)))
legend('Magnitude (actual)','Magnitude (expected)')
subplot(2,1,2)
plot(theta,double(magnitudeZ)-abs(double(Z)));
legend('Error')
set(1,'Name','Magnitude','WindowStyle','Docked');

figure(2)
clf
subplot(2,1,1)
plot(theta,unwrap(double(angleZ)),theta,unwrap(angle(double(Z))))
legend('Angle (actual)','Angle (expected)')
subplot(2,1,2)
plot(theta,unwrap(double(angleZ))-unwrap(angle(double(Z))));
legend('Error')
set(2,'Name','Angle','WindowStyle','Docked');
%% Visualize
vis = VisualizeDatatypes('cordic_cart2pol_instrumented',3);
%% Generate C Code
codegen cordic_cart2pol -args {Z(1)} -config:lib -launchreport
%% Generate HDL Code
% You can generate HDL code for this function.  Even though the generated
% HDL code is high quality, there is a loop.  The loop means that the code
% has to finish executing before the next clock tick, which means that the
% clock can't go faster than this code can go.  An ASIC or FPGA can only go
% as fast as the longest path between registers (known in Simulink as Delay
% blocks).  It is possible to further elaborate the MATLAB code to add
% registers, parallelization, and timing, but it is easier and more natural
% to elaborate the design in Simulink for efficient HDL code generation.
%
% The following model and test script in this directory show how to
% integrate the CORDIC kernel in MATLAB with Simulink to implement a
% hardware-optimized CORDIC algorithm that shares the resources for the
% kernel.
%
%     simulink_cordic_cart2pol_model.slx
%     test_simulink_cordic_cart2pol.m
codegen cordic_cart2pol -args {Z(1)} -config:hdl


