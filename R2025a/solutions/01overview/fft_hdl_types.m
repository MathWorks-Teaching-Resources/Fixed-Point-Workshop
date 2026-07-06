function T = fft_hdl_types(fidatatype,prototypevalue) %#ok<INUSD>
    if nargin < 1
        fidatatype = 'Fixed';
    end
    if nargin < 2
        prototypevalue = 1i; %#ok<NASGU>
    end
    F = fimath('RoundingMethod','Floor',...
        'OverflowAction','Wrap',...
        'ProductMode','KeepLSB',...
        'ProductWordLength',36,...
        'SumMode','KeepLSB',...
        'SumWordLength',36);
    % Variables that are always complex
    T.x = fi(0.01i,true,18,16,F,'DataType',fidatatype);
    T.w = fi(0.01i,true,18,16,F,'DataType',fidatatype);
end