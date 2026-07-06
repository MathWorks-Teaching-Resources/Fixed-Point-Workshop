%% Test Hardware Efficient Model for Orthographic Projection

%% Setup workspace with data
m = 10;
n = 10;
numSamples = n*m;

wl = 24;
fl = 18;
dt = numerictype(1,wl,fl);
nIters = wl - 1;

RE = fi(6.371e3, 1, wl, 5);

%% Setup Sample Data
% Using Coords of Natick, MA here
phi0 = (42.3/180)*pi;
lambda0 = -(71.35/180)*pi;

halfAngle = (1.5*pi/180);

phiVals = linspace(phi0+halfAngle,phi0-halfAngle,m);
lambdaVals = linspace(lambda0 - halfAngle, lambda0 + halfAngle,n);

[phiGr, lambdaGr] = ndgrid(phiVals,lambdaVals);

phiVec = fi(phiGr(:), dt, hdlfimath);
lambdaVec = fi(lambdaGr(:), dt, hdlfimath);
phi0Val = cast(phi0,'like',phiVec);
lambda0Val = cast(lambda0,'like',lambdaVec);

%% Setup and simulate the model

mdl = 'orthographic_projection_tb';
open_system(mdl);
out = sim(mdl);

%% Get a baseline for the system
xb = zeros(numSamples,1);
yb = zeros(numSamples,1);
hb = zeros(numSamples,1);
for ii = 1:numSamples
 [xb(ii),yb(ii),hb(ii)] = ortho.baseline(single(phiGr(ii)),single(phi0),single(lambdaGr(ii)),single(lambda0));
end

%% Plot the results
fig = 1;
figure(fig)
clf
subplot(2,1,1);
hold on;
title('X Component');
plot(single(RE)*xb,'r-');
plot(single(out.X),'b-');
subplot(2,1,2);
hold on;
title('Y Component');
plot(single(RE)*yb,'r-');
plot(single(out.Y),'b-');
legend({'Baseline','Simulation'});
set(fig,'Name','Orthographic Projection','WindowStyle','Docked')