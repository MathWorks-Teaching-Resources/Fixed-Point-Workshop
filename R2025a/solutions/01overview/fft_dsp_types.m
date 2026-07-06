function T = fft_dsp_types(fidatatype,prototypevalue) %#ok<INUSD>
    if nargin < 1
        fidatatype = 'Fixed';
    end
    if nargin < 2
        prototypevalue = 1i; %#ok<NASGU>
    end
    F = fimath('RoundingMethod','Floor',...
        'OverflowAction','Wrap',...
        'ProductMode','KeepLSB',...
        'ProductWordLength',32,...
        'SumMode','KeepLSB',...
        'SumWordLength',32);
    % Variables that are always complex
    T.x = fi(0.01i,true,16,14,F,'DataType',fidatatype);
    T.w = fi(0.01i,true,16,14,F,'DataType',fidatatype);
end