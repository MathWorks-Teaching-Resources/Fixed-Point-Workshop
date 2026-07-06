function validateNotFloat(d_in, dt_str, varname, fcnname)
    %validateNotFloat Validate that input is not floating point
    %
    %   FOR INTERNAL USE ONLY -- This feature is intentionally
    %   undocumented. Its behavior may change, or it may be removed in a
    %   future release.
    
    % Copyright 2019 The MathWorks, Inc.
    
    coder.internal.assert(~fixed.internal.type.isAnyFloatOrScaledDouble(d_in), 'fixed:fi:invalidDataType',dt_str, varname, fcnname);
    
end