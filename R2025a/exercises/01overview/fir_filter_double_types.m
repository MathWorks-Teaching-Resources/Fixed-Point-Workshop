function T = fir_filter_double_types(prototypevalue)
    if nargin<1
        prototypevalue = 0.01i;
    else
        prototypevalue = double(prototypevalue);
    end
    % Variables that are always real-valued
    T.p = int16([]);
    T.coeff = [];
    % Variables that may be complex values
    T.acc = prototypevalue;
    T.x = prototypevalue;
    T.y = prototypevalue;
    T.z = prototypevalue;
end
