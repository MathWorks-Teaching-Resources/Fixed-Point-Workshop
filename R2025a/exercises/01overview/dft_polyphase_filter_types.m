function T = dft_polyphase_filter_types(datatypeselector,fidatatype,prototypevalue,filter_coefficients)
    if nargin < 1
        datatypeselector = 'double';
    end
    if nargin < 2
        fidatatype = 'Fixed';
    end
    if nargin < 3
        prototypevalue = 1i;
    end
    if nargin < 4
        filter_coefficients = 0.25;
    end
    switch datatypeselector
        case 'double'
            T.fir_filter = fir_filter_double_types(prototypevalue);
            T.fft = fft_double_types;
        case 'single'
            T.fir_filter = fir_filter_single_types(prototypevalue);
            T.fft = fft_single_types;
        case 'dsp'
            T.fir_filter = fir_filter_dsp_types(fidatatype,prototypevalue,filter_coefficients);
            T.fft = fft_dsp_types(fidatatype,prototypevalue);
        case 'hdl'
            T.fir_filter = fir_filter_hdl_types(fidatatype,prototypevalue,filter_coefficients);
            T.fft = fft_hdl_types(fidatatype,prototypevalue);
        otherwise
            error([datatypeselector,' not a valid data type selection'])
    end
end

