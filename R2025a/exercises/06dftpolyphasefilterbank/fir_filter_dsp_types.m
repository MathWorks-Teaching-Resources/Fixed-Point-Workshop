function T = fir_filter_dsp_types(fidatatype,prototypevalue,filter_coefficients)
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
        'ProductWordLength',32,...
        'SumMode','KeepLSB',...
        'SumWordLength',32);
    % Variables that are always real
    T.p = int16([]);
    % Let the coefficients auto-scale
    T.coeff = fi(filter_coefficients,true,16,F,'DataType',fidatatype);
    % Variables that are complex if prototypevalue is complex
    T.acc = fi(prototypevalue,true,32,30,F,'DataType',fidatatype);
    T.x = fi(prototypevalue,true,16,14,F,'DataType',fidatatype);
    T.y = fi(prototypevalue,true,16,14,F,'DataType',fidatatype);
    T.z = fi(prototypevalue,true,16,14,F,'DataType',fidatatype);
end
