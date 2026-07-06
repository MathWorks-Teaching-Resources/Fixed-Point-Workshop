function atan_table = normalizedCORDICAtanTable(niter,T)
    %normalizedCORDICAtanTable

    %   Copyright 2022 The MathWorks, Inc.
    %#codegen

    % 1 == 2pi
    % 0.5 == pi
    %#codegen
    atan_table = cast(atan(2 .^ -(0:(double(niter)-1)))/2/pi,'like',T);
    % TODO: Add high precision table
    %  coder.extrinsic('highPrecisionNormalizedCORDICAtanTable');
    %  if isfi(T)
    %      [atan_table_char_array,len] = coder.const(@highPrecisionNormalizedCORDICAtanTable,niter);
    %      atan_table = fi(zeros(1,len),T.numerictype,'Value',atan_table_char_array);
    %  else
    %      atan_table = cast(atan(2 .^ -(0:(double(niter)-1)))/pi,'like',T);
    % end
end
