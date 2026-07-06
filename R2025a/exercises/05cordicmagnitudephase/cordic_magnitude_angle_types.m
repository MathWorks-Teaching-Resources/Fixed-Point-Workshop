function [T,N,a] = cordic_magnitude_angle_types(z)
    if isfi(z)
        datatype = z.DataType;
        w = z.WordLength;
        N = w - 1;
        f = z.FractionLength;
        F_xy = fimath('RoundingMethod', 'Floor', ...
            'OverflowAction', 'Wrap',...
            'SumMode','SpecifyPrecision',...
            'SumWordLength',w,...
            'SumFractionLength',w-3);
        F_theta = fimath('RoundingMethod', 'Floor', ...
            'OverflowAction', 'Wrap',...
            'SumMode','SpecifyPrecision',...
            'SumWordLength',w,...
            'SumFractionLength',w-4);
        T.a = fi([],0,w,w-1,'DataType',datatype);
        T.x = fi([],1,w,w-3,F_xy,'DataType',datatype);
        T.y = fi([],1,w,w-3,F_xy,'DataType',datatype);
        T.theta = fi([],1,w,w-4,F_theta,'DataType',datatype);
        % Create the angle table with no fimath and default nearest rounding.
        a = fi(cordic_angular_increments(N),T.theta.numerictype);
    else
        N = 52;
        T.a = cast([],'like',z);
        T.x = cast([],'like',z);
        T.y = cast([],'like',z);
        T.theta = cast([],'like',z);
        a = cast(cordic_angular_increments(N),'like',z);
    end
end