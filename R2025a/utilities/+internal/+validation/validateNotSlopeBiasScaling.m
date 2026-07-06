function validateNotSlopeBiasScaling(d_in, dt_str, varname, fcnname)
    %validateNotSlopeBiasScaling Validate that d_in is not a slope-bias scaled fi object
    %
    %   FOR INTERNAL USE ONLY -- This feature is intentionally
    %   undocumented. Its behavior may change, or it may be removed in a
    %   future release.
    
    % Copyright 2019 The MathWorks, Inc.
    
    coder.internal.assert(~(isfi(d_in) && isscalingslopebias(d_in)), 'fixed:fi:invalidDataType', dt_str, varname, fcnname);
    
end