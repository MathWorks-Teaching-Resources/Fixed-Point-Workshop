function cordic_check_theta_arg(theta, fcnStr)
    %CORDIC_CHECK_THETA_ARG Common argument checking for CORDIC THETA argument
    %   See code below for more details.
    
    % Copyright 2010-2019 The MathWorks, Inc.
        
    
    
    % Define theta as a column vector locally for convenience. This allows
    % us to run vectorized checks on the data's properties
    theta = theta(:);
    
    isUnsupportedClass = ~any(cellfun(@(x)isa(theta, x), getSupportedClasses()));
    isNanOrInf = any(isnan(theta)) || any(isinf(theta));
    isComplex = any(~isreal(theta));
    
    dbl_theta_array = double(theta);
    isOutOfRange = any(dbl_theta_array < -2*pi) || any(dbl_theta_array >= (2*pi + 2*eps));
    isEmpty = isempty(theta);
    
    if isUnsupportedClass
       msgID = message('fixed:cordic:invalidDataType', class(theta), fcnStr);
       error(msgID);
    end
    
    if isComplex || isEmpty || isNanOrInf
       msgID = message('fixed:cordic:invalidThetaValue', fcnStr);
       error(msgID);
    end
    
    if isOutOfRange 
       msgID = message('fixed:cordic:thetaValueOutOfRange',fcnStr);
       error(msgID);
    end
    
    isBoolean = fixed.internal.type.isAnyBoolean(theta);
    if isBoolean
        msgID = message('fixed:fi:unsupportedDataType', 'boolean');
        error(msgID);
    end    
    
end

function supported_classes = getSupportedClasses()
    
    ml_ints = fixed.internal.type.namesMATLABInts;
    supported_classes = [{'single', 'double','embedded.fi'}, ml_ints'];
    
end

