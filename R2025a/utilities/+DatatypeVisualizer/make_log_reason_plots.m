function make_log_reason_plots(E,mex_name,fun_name)
% Datatype visualization beta.
    
%   Tom Bryan and Julia Wall, 5 April 2015
%   Copyright 2015-2022 The MathWorks, Inc.

    if nargin < 2
        mex_name = '';
    end
    if nargin < 3
        fun_name = '';
    end
    
    if isempty(mex_name) && isempty(fun_name)
        title_suffix = '';
        file_prefix = ['history',filesep];
    else
        if isempty(fun_name)
            title_suffix = [' (',mex_name,')'];
            file_prefix = fullfile('history',mex_name);
        else
            title_suffix = [' (',mex_name,' > ',fun_name,')'];
            file_prefix = fullfile('history',[mex_name,'_',fun_name]);
        end
    end


    if ~isempty(fun_name)
        E = E(strcmp(E.FunctionName,fun_name),:);
    end


    LogReason = unique(E.LogReason);

    for n = 1:length(LogReason)

        R = E(strcmp(E.LogReason,LogReason{n}),:);
        
        figure;
        DatatypeVisualizer.plot_expressions_max_to_min(R)
        grid off
        title([LogReason{n},' expressions',title_suffix],'Interpreter','none')
        % file_name = [file_prefix,'_',LogReason{n},'_expressions_max_to_min'];
        % if ~exist(file_name,'file')
        %     print('-dpdf',file_name);
        % end

    %     figure;
    %     DatatypeVisualizer.plot_expressions_sorted_by_type(R)
    %     grid off
    %     title([LogReason{n},' expressions sorted by type',title_suffix],'Interpreter','none')
    %     file_name = [file_prefix,'_',LogReason{n},'_expressions_by_type'];
    %     if ~exist(file_name,'file')
    %         print('-dpdf',file_name);
    %     end

    %     figure
    %     DatatypeVisualizer.plot_by_dynamic_range(R);
    %     grid off
    %     title([LogReason{n},'expressions sorted by dynamic range, then type, ' ...
    %            'then magnitude',title_suffix],'Interpreter','none')
    %     file_name = [file_prefix,'_',LogReason{n},'_dynamic_range_sorted'];
    %     if ~exist(file_name,'file')
    %         print('-dpdf',file_name);
    %     end

    %     figure;
    %     DatatypeVisualizer.plot_by_histogram_range(R);
    %     grid off
    %     title([LogReason{n},' expressions by dynamic range',title_suffix],'Interpreter','none')
    %     file_name = [file_prefix,'_',LogReason{n},...
    %                  '_expressions_histogram_range'];
    %     if ~exist(file_name,'file')
    %         print('-dpdf',file_name);
    %     end

    % end

end
