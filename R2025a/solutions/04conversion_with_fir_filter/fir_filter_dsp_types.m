function T = fir_filter_dsp_types(dataType)
    if nargin < 1
        dataType = 'Fixed';
    end
    F = fimath('RoundingMethod','Floor',...
        'OverflowAction','Wrap',...
        'ProductMode','FullPrecision',...
        'SumMode','SpecifyPrecision',...
        'SumWordLength',32,...
        'SumFractionLength',30);
    % Don't attach fimath to the coefficient type.
    % They are constant, so let the round to nearest
    % for more accuracy.
    T.coefficient = fi([],1,16,16,'DataType',dataType);
    T.input       = fi([],1,16,14,F,'DataType',dataType);
    T.output      = fi([],1,16,14,F,'DataType',dataType);
    T.sum         = fi([],1,32,30,F,'DataType',dataType);
    T.index = int32([]);
end
