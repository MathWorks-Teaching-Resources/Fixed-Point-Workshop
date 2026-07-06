function display_double_types(~,~,E)
% Datatype visualization beta.
    
%   Tom Bryan and Julia Wall, 5 April 2015
%   Copyright 2015-2022 The MathWorks, Inc.

    [~,y] = ginput(1);
    ticklabels = get(gca,'YTickLabel');
    
    fun_name = ticklabels{round(y)};

    figure
    DatatypeVisualizer.plot_double_whole_numbers(E,fun_name);
    set(gcf,'WindowStyle','Docked')
    
    figure
    DatatypeVisualizer.plot_double_non_whole_numbers(E,fun_name);
    set(gcf,'WindowStyle','Docked')
end
