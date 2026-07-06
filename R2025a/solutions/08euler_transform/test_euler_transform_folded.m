%% Define global parameters

nIters = 14;
WL = 14;
FL = 10;
dt = fixdt(1,WL,FL);

%% Main Loop
dataVec = {[0 1 0], [0 0 1], [1 0 0]};
dataNum = [0 1 2];
angleName = {'\phi','\theta','\psi'};
for ii = dataNum
    selData = dataNum(ii+1);
    uIn = fi(dataVec{ii + 1}, dt);
    [phiIn, thetaIn, psiIn] = euler.datautils.sampleAnglesStdBasis(ii+1,1000);
    phiVals = fi(phiIn, dt);
    thetaVals = fi(thetaIn, dt);
    psiVals = fi(psiIn, dt);
    
%% Load the model

    open_system euler_transform_folded
    
%% Simulate
    
    sim euler_transform_folded
    
%% Calsulate a baseline for the output

    uBaseline = euler.datautils.getBaseline(phiIn, thetaIn, psiIn, ii + 1);
    
%% Calculate a baseline for the output
    
    switch ii
        case 0
            angles = phiIn;
        case 1
            angles = thetaIn;
        case 2
            angles = psiIn;
    end
    
    euler.datautils.plotResultAndBaseline(ii+1, uOut', uBaseline, uIn, angles, angleName{ii + 1});
end