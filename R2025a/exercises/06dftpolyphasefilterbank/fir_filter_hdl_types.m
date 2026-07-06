function T = fir_filter_hdl_types(fidatatype,prototypevalue,filter_coefficients)
    if nargin < 1
        fidatatype = 'Fixed';
    end
    if nargin < 2
        prototypevalue = 1i;
    end
    if nargin < 3
        filter_coefficients = 0.25;
    end
    F = fimath('RoundingMethod','Floor',...
        'OverflowAction','Wrap',...
        'ProductMode','KeepLSB',...
        'ProductWordLength',36,...
        'SumMode','KeepLSB',...
        'SumWordLength',39);
    % Variables that are always real
    T.p = int16([]);
    % Let the coefficients auto-scale
    T.coeff = fi(filter_coefficients,true,14,F,'DataType',fidatatype);
    % Variables that are complex if prototypevalue is complex
    T.acc = fi(prototypevalue,true,39,37,F,'DataType',fidatatype);
    T.x = fi(prototypevalue,true,14,12,F,'DataType',fidatatype);
    T.y = fi(prototypevalue,true,18,16,F,'DataType',fidatatype);
    T.z = fi(prototypevalue,true,14,12,F,'DataType',fidatatype);
end
