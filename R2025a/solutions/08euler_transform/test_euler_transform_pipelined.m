%% Define global parameters

nIters = 14;
WL = 14;
FL = 10;
dt = fixdt(1,WL,FL);

%% Main Loop
dataVec = {[0 1 0], [0 0 1], [1 0 0]};
axisNum = [1 2 3];
angleName = {'\phi','\theta','\psi'};
for ii = axisNum
%% Define input data
uIn = fi(dataVec{ii},dt);

[phiVals, thetaVals, psiVals] = ...
    euler.datautils.sampleAnglesStdBasis(ii,1000);

phiIn = euler.datautils.makeSLStruct(fi(phiVals, dt));
thetaIn = euler.datautils.makeSLStruct(fi(thetaVals, dt));
psiIn = euler.datautils.makeSLStruct(fi(psiVals, dt));

%% Load the model

open_system euler_transform_pipelined

%% Simulate

sim euler_transform_pipelined

%% Calculate a baseline for the output

uBaseline = euler.datautils.getBaseline(phiVals, thetaVals, psiVals, ii);

%% Plot the outputs against one another

switch ii
    case 1
        angles = phiVals;
    case 2
        angles = thetaVals;
    case 3
        angles = psiVals;
end

uData = uOut(validOut,:)';
euler.datautils.plotResultAndBaseline(ii+1, uData(:,1:1000), uBaseline, uIn, angles, angleName{ii});

end

