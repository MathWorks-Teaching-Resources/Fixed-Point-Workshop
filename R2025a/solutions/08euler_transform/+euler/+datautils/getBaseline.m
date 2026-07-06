function uOut = getBaseline(phiIn, thetaIn, psiIn, axNum)
    
    % Copyright 2018 The MathWorks, Inc.
   
    switch axNum
        case 1
            uOut = repmat([0;1;0],1,length(phiIn));
            for ii = 1:length(phiIn)
                R = euler.makeRotationMatrix(phiIn(ii),thetaIn,psiIn);
                uOut(:,ii) = R*uOut(:,ii);
            end
        case 2
            uOut = repmat([0;0;1],1,length(thetaIn));
            for ii = 1:length(thetaIn)
                R = euler.makeRotationMatrix(phiIn,thetaIn(ii),psiIn);
                uOut(:,ii) = R*uOut(:,ii);
            end
        case 3
            uOut = repmat([1;0;0],1,length(psiIn));
            for ii = 1:length(psiIn)
                R = euler.makeRotationMatrix(phiIn,thetaIn,psiIn(ii));
                uOut(:,ii) = R*uOut(:,ii);
            end
        otherwise
            error('axNum must equal 1, 2, or 3');        
    end
end