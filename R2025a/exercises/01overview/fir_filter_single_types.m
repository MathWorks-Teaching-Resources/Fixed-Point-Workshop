function T = fir_filter_single_types(prototypevalue)
    if nargin<1
        prototypevalue = single(0.01i);
    else
        prototypevalue = single(prototypevalue);
    end
    % Variables that are always real-valued
    T.p = int16([]);
    T.coeff = single([]);
    % Variables that may be complex values
    T.acc = prototypevalue;
    T.x = prototypevalue;
    T.y = prototypevalue;
    T.z = prototypevalue;
end

