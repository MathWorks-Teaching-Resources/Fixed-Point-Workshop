function [phi, theta, psi] = sampleAnglesStdBasis(axNum, numPoints)
% sampleAngleStdBasis creates uniformly sampled angles about the x, y, or z
% axis
 
    % Copyright 2018 The MathWorks, Inc.
    switch axNum
        case 1
            % Rotate about +x axis
            phi = linspace(0,2*pi,numPoints);
            theta = 0;
            psi = 0;
        case 2
            % Rotate about +y axis
            phi = 0;
            theta = linspace(0,pi,numPoints);
            psi = 0;
        case 3
            % Rotate about +z axis
            phi = 0;
            theta = 0;
            psi = linspace(0,2*pi,numPoints);
        otherwise
            error('axNum must be 1, 2, or 3');
    end

end