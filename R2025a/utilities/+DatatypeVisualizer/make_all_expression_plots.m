function [E,V] = make_all_expression_plots(CompilationReport,mex_name,fun_name)
% Datatype visualization beta.
    
%   Tom Bryan and Julia Wall, 5 April 2015
%   Copyright 2015-2022 The MathWorks, Inc.

    if nargin < 2
        mex_name = '';
    end
    if nargin < 3
        fun_name = '';
    end
    
    [E,V] = DatatypeVisualizer.make_expression_tables_from_compilation_report(CompilationReport);
    
    if ~isempty(fun_name)
        E = E(strcmp(E.FunctionName,fun_name),:);
        V = V(strcmp(V.FunctionName,fun_name),:);
    end
    
    if ~isempty(mex_name)
    else
    end
    
    if isempty(mex_name) && isempty(fun_name)
        title_suffix = '';
        file_prefix = ['history',filesep];
    else
        title_suffix = [' (',mex_name,' > ',fun_name,')'];
        file_prefix = fullfile('history',[mex_name,'_',fun_name]);
    end
    
    title_suffix = '';
    
    %%
    figure;
    TE = DatatypeVisualizer.bar_plot_all_types(E);
    title(['Expressions',title_suffix],'Interpreter','none')
    file_name = [file_prefix,'_expression_types'];
    if ~exist(file_name,'file')
        print('-dpdf',file_name);
    end
    
    
    figure;
    TV = DatatypeVisualizer.bar_plot_all_types(V);
    grid off
    title(['Variables',title_suffix],'Interpreter','none')
    file_name = [file_prefix,'_variable_types'];
    if ~exist(file_name,'file')
        print('-dpdf',file_name);
    end
    
    figure;
    DatatypeVisualizer.plot_expressions_sorted_by_type(E)
    grid off
    title(['All expressions sorted by type',title_suffix],'Interpreter','none')
    file_name = [file_prefix,'_expressions_by_type'];
    if ~exist(file_name,'file')
        print('-dpdf',file_name);
    end
    
    figure;
    DatatypeVisualizer.plot_expressions_sorted_by_type(V)
    grid off
    title(['All variables sorted by type',title_suffix],'Interpreter','none')
    file_name = [file_prefix,'_variables_by_type'];
    if ~exist(file_name,'file')
        print('-dpdf',file_name);
    end
    
    figure;
    % plot overflow and underflow for variables & expressions
    DatatypeVisualizer.plot_overflow_and_underflow(E,V)
    title(['Overflow and underflow',title_suffix],'Interpreter','none')
    file_name = [file_prefix,'_overflow_and_underflow'];
    if ~exist(file_name,'file')
        print('-dpdf',file_name);
    end
    
    figure;
    DatatypeVisualizer.plot_by_histogram_range(E(E.IsAlwaysWholeNumber,:));
    grid off
    title(['Always whole number expressions',title_suffix],'Interpreter','none')
    file_name = [file_prefix,'_expressions_histogram_range_always_whole'];
    if ~exist(file_name,'file')
        print('-dpdf',file_name);
    end
    
    figure
    DatatypeVisualizer.plot_by_histogram_range(E(~E.IsAlwaysWholeNumber,:));
    grid off
    title(['Not always whole number expressions',title_suffix],'Interpreter','none')
    file_name = [file_prefix,'_expressions_histogram_range_not_always_whole'];
    if ~exist(file_name,'file')
        print('-dpdf',file_name);
    end
    
    figure;
    DatatypeVisualizer.plot_by_histogram_range(V(V.IsAlwaysWholeNumber,:));
    grid off
    title(['Always whole number variables',title_suffix],'Interpreter','none')
    file_name = [file_prefix,'_variables_histogram_range_always_whole'];
    if ~exist(file_name,'file')
        print('-dpdf',file_name);
    end
    
    figure
    DatatypeVisualizer.plot_by_histogram_range(V(~V.IsAlwaysWholeNumber,:));
    grid off
    title(['Not always whole number variables',title_suffix],'Interpreter','none')
    file_name = [file_prefix,'_variables_histogram_range_not_always_whole'];
    if ~exist(file_name,'file')
        print('-dpdf',file_name);
    end
    
    figure
    DatatypeVisualizer.plot_by_histogram_range(V);
    grid off
    title(['All variables by histogram range',title_suffix],'Interpreter','none')
    file_name = [file_prefix,'_variables_histogram'];
    if ~exist(file_name,'file')
        print('-dpdf',file_name);
    end
    
    figure
    DatatypeVisualizer.plot_by_dynamic_range(E);
    grid off
    title(['Expressions sorted by dynamic range, then type, ' ...
        'then magnitude',title_suffix])
    file_name = [file_prefix,'_expressions_dynamic_range'];
    if ~exist(file_name,'file')
        print('-dpdf',file_name);
    end
    
    figure
    DatatypeVisualizer.plot_by_dynamic_range(E(E.IsAlwaysWholeNumber,:));
    grid off
    title(['Always whole number expressions sorted by dynamic range, then type, ' ...
        'then magnitude',title_suffix])
    file_name = [file_prefix,'_whole_expressions_dynamic_range'];
    if ~exist(file_name,'file')
        print('-dpdf',file_name);
    end

    figure
    DatatypeVisualizer.plot_by_dynamic_range(E(~E.IsAlwaysWholeNumber,:));
    grid off
    title(['Always whole number expressions sorted by dynamic range, then type, ' ...
        'then magnitude',title_suffix])
    file_name = [file_prefix,'_not_whole_expressions_dynamic_range'];
    if ~exist(file_name,'file')
        print('-dpdf',file_name);
    end

    figure
    DatatypeVisualizer.plot_by_dynamic_range(V(V.IsAlwaysWholeNumber,:));
    grid off
    title(['Always whole number variables sorted by dynamic range, then type, ' ...
        'then magnitude',title_suffix])
    file_name = [file_prefix,'_whole_variables_dynamic_range'];
    if ~exist(file_name,'file')
        print('-dpdf',file_name);
    end

    figure
    DatatypeVisualizer.plot_by_dynamic_range(V(~V.IsAlwaysWholeNumber,:));
    grid off
    title(['Not always whole number variables sorted by dynamic range, then type, ' ...
        'then magnitude',title_suffix])
    file_name = [file_prefix,'_not_whole_variables_dynamic_range'];
    if ~exist(file_name,'file')
        print('-dpdf',file_name);
    end


    figure
    DatatypeVisualizer.plot_by_dynamic_range(V);
    grid off
    title(['Variables sorted by dynamic range, then type, ' ...
        'then magnitude',title_suffix])
    file_name = [file_prefix,'_variables_histogram'];
    if ~exist(file_name,'file')
        print('-dpdf',file_name);
    end
    
    figure
    DatatypeVisualizer.bar_plot_fi_types(E)
    title('Fixed-point expressions')
    file_name = [file_prefix,'_fixed_point_expressions'];
    if ~exist(file_name,'file')
        print('-dpdf',file_name);
    end
    
    figure;
    DatatypeVisualizer.bar_plot_fi_types(V)
    title('Fixed-point variables');
    file_name = [file_prefix,'fixed_point_variables'];
    if ~exist(file_name,'file')
        print('-dpdf',file_name);
    end
    
    
end
