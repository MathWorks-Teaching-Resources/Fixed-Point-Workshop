function plot_unknown_and_double_non_whole_numbers(E,fun_name,my_title)
% Datatype visualization beta.
    
%   Tom Bryan and Julia Wall, 5 April 2015
%   Copyright 2015-2022 The MathWorks, Inc.


    if nargin<2, fun_name=''; end

    if nargin<3
        my_title = 'Not Always Whole Numbers';
    end
    W = E(~E.IsAlwaysWholeNumber,:);

    DatatypeVisualizer.plot_unknown_and_double(W,fun_name,my_title);
    
end
