function T = fir_filter_dsp_types(dataType)
    if nargin < 1
        dataType = 'Fixed';
    end
    T.coefficient = fi([],'DataType',dataType);
    T.input       = fi([],'DataType',dataType);
    T.output      = fi([],'DataType',dataType);
    T.sum         = fi([],'DataType',dataType);
    T.index = int32([]);
end
