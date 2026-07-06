function [X, Y, H] = baseline(phi,phi0,lambda,lambda0)
    
    X = cos(phi)*sin(lambda - lambda0);
    Y = cos(phi0)*sin(phi)-sin(phi0)*cos(phi)*cos(lambda-lambda0);
    H = sin(phi0)*sin(phi)+cos(phi0)*cos(phi)*cos(lambda-lambda0);