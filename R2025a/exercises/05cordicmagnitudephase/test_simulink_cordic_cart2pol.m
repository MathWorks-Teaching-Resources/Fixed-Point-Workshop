% Test script for simulink_cordic_cart2pol_model
model = 'simulink_cordic_cart2pol_model';
open_system(model);

% Define inputs
x = rand(1,20)*2-1;
y = rand(1,20)*2-1;
[x_in,y_in] = meshgrid(x,y);

% Define data type
wl_xy = 16;  fl_xy = 13;  % WL = FL+3 for bit growth
wl_ang = 16; fl_ang = 14; % WL = FL+2 for bit growth

dt_xy = numerictype(1,wl_xy,fl_xy);
dt_ang = numerictype(1,wl_ang,fl_ang);

% Algorithm parameters
niter = 10; % should be <= wl_xy
cordic_table = fi(atan(2.^-(0:niter-1))/pi,dt_ang);
cordic_a0 = cordic_table(1);

% Set min & max gap between input samples
% Examples:
% [0 0]: input is always ready
% [niter-1 niter-1]: input ready at the same rate as DUT
% [0 niter+5]: either source or DUT is waiting 
gap = [0 niter+5];

% Test pipeline register. This is to show pipelining does not affect
% throughput
pipe = 1; 

% Simulate model
sim(model);

%% Compare to reference
t = 1:numel(x_in);

figure(1);
h21 = subplot(2,1,1);
Kn = inverse_cordic_growth_constant(niter);
plot(t,hypot(double(x_in(:)),double(y_in(:))),t,Kn*double(magnitude_sl(:)));
title('Magnitude')
legend('Reference','Model')
h22 = subplot(2,1,2);
plot(t,hypot(double(x_in(:)),double(y_in(:))) - Kn*double(magnitude_sl(:)));
legend('Error')
linkaxes([h21,h22],'x');

atan_ref = atan2(y_in,x_in)/pi;
figure(2);
h11 = subplot(2,1,1);
plot(t,atan_ref(:),t,atan_sl(:))
title('Phase')
legend('Reference','Model')
h12 = subplot(2,1,2);
plot(t,atan_ref(:) - double(atan_sl(:)));
legend('Error')
linkaxes([h11,h12],'x');


