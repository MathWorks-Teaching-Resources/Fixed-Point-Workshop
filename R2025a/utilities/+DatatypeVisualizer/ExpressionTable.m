classdef ExpressionTable
    %DatatypeVisualizer.ExpressionTable

%   Copyright 2022 The MathWorks, Inc.

    properties
        Expressions
        Variables
        CompilationReport
        % Also store the inference report so we can reproduce the
        % snapshot of the report
    end % properties
    methods(Static,Access=private)
        function write_table(T,file_name)
            % Delete Histograms because they expand to one column per entry
            T.HistogramOfPositiveValues = [];
            T.HistogramOfNegativeValues = [];
            % Delete Prototype because it could be fi, which isn't
            % supported by writetable
            T.Prototype = [];
            writetable(T,file_name)
        end
    end
    methods
        function vis = ExpressionTable(mexname)
            [e,v,compilation_report] = DatatypeVisualizer.make_expression_tables_from_instrumented_mex(mexname);
            vis.Expressions = e;
            vis.Variables = v;
            vis.CompilationReport = compilation_report;
        end % ExpressionTable constructor
        
        function fig = visualize(vis,initial_figure,fun)
            if nargin<2
                initial_figure = [];
            end
            if isempty(initial_figure)
                % To allow the first figure to be defaulted if you want to just enter
                % FUN.
                initial_figure = 1;
            end
            fig = initial_figure;
            if nargin<3
                fun = '';
            end
            global PLOT_EXPRESSION_NAMES
        
            plot_expression_names = true;
            PLOT_EXPRESSION_NAMES = plot_expression_names;
            
            global MAX_EXPRESSIONS_TO_LABEL
            MAX_EXPRESSIONS_TO_LABEL = 400;

            global EXPRESSION_TABLE_PLOT_FUNCTION
            E = vis.Expressions;
            V = vis.Variables;
            if ~isempty(fun)
                % Only show the function named by fun
                E = E(strcmp(E.FunctionName,fun),:);
                V = V(strcmp(V.FunctionName,fun),:);
            end
            
            EXPRESSION_TABLE_PLOT_FUNCTION = @DatatypeVisualizer.plot_expression_table;
            DatatypeVisualizer.visualize_plot(fig,@DatatypeVisualizer.plot_expressions_max_to_min,E,'All Expressions',false);
            
            % EXPRESSION_TABLE_PLOT_FUNCTION = @DatatypeVisualizer.plot_expression_table3;
            fig = fig + 1;
            DatatypeVisualizer.visualize_plot(fig,@DatatypeVisualizer.plot_non_whole_numbers,V,'Variables max to min (not whole numbers)',plot_expression_names);
    

            fig = fig + 1;
            DatatypeVisualizer.visualize_plot(fig,@DatatypeVisualizer.plot_non_whole_numbers_by_function,V,'Variables by function (not whole numbers)',plot_expression_names);
    
            fig = fig + 1;
            DatatypeVisualizer.visualize_plot(fig,@DatatypeVisualizer.plot_expressions_sorted_by_type,V,'Variables by data type',plot_expression_names);
    
            fig = fig + 1;
            DatatypeVisualizer.visualize_plot(fig,@DatatypeVisualizer.plot_whole_numbers_by_function,V,'Variables (whole numbers)',plot_expression_names);
            
            fig = fig + 1;
            DatatypeVisualizer.visualize_plot(fig,@DatatypeVisualizer.plot_non_whole_numbers_by_function,E,'Expressions by function (not whole numbers)',plot_expression_names);
    
            fig = fig + 1;
            DatatypeVisualizer.visualize_plot(fig,@DatatypeVisualizer.plot_expressions_sorted_by_type,E,'Expressions by data type',plot_expression_names);
            
            fig = fig + 1;
            DatatypeVisualizer.visualize_plot(fig,@DatatypeVisualizer.plot_overflow_by_function,E,'Overflows',plot_expression_names);
    
            fig = fig + 1;
            DatatypeVisualizer.visualize_plot(fig,@DatatypeVisualizer.plot_by_function,E(E.Underflow,:),'Underflows',plot_expression_names);
    
            fig = fig + 1;
            DatatypeVisualizer.visualize_log_reason(fig,{'ADD','SUBTRACT'},@DatatypeVisualizer.plot_non_whole_numbers_by_function,E,...
                                 'Sums',plot_expression_names)
            set(gcf,'Name','Sums','WindowStyle','Docked');
    
            fig = fig + 2;
            DatatypeVisualizer.visualize_log_reason(fig,{'MULTIPLY'},@DatatypeVisualizer.plot_non_whole_numbers_by_function,E,...
                                 'Products',plot_expression_names)
            set(gcf,'Name','Products','WindowStyle','Docked');
            
            fig = fig + 1;
            DatatypeVisualizer.visualize_log_reason(fig,{'DIVIDE'},@DatatypeVisualizer.plot_non_whole_numbers_by_function,E,...
                                 'Divides',plot_expression_names)
            set(gcf,'Name','Divides','WindowStyle','Docked');
            
%             fig = fig + 1;
%             figure(fig)
%             DatatypeVisualizer.bar_plot_all_types(E);
%             set(gcf,'Name','Types','WindowStyle','Docked');
            
    
            figure(initial_figure)
        end % visualize
        
        function v = getVariable(vis,variable_name)
            v = vis.Variables(strcmp(vis.Variables.Expression,variable_name),:);
        end
        
        function e = getExpression(vis,expression_name)
            e = vis.Expressions(strcmp(vis.Expressions.Expression,expression_name),:);
        end
        
        function f = getFunctionExpressions(vis,function_name)
            f = vis.Expressions(strcmp(vis.Expressions.FunctionName,function_name),:);
        end
        
        function f = getFunctionVariables(vis,function_name)
            f = vis.Variables(strcmp(vis.Variables.FunctionName,function_name),:);
        end
        
        function writeVariables(vis, file_name)
            T = vis.Variables;
            DatatypeVisualizer.ExpressionTable.write_table(T,file_name);
        end
        
        function writeExpressions(vis, file_name)
            T = vis.Expressions;
            DatatypeVisualizer.ExpressionTable.write_table(T,file_name);
        end
        
        function vis = merge(varargin)
            for n = 1:length(varargin)
                assert(isa(varargin{n}, 'DatatypeVisualizer.ExpressionTable'),...
                    'All inputs to ''merge'' must be DatatypeVisualizer.ExpressionTable objects');
            end
            vis = varargin{1};
            if nargin>1
                % TBD: Skipping the detail that the CompilationReport must point
                % to the same functions for now.
                vis2 = varargin{2};
                vis.Expressions = vertcat(vis.Expressions,vis2.Expressions);
                vis.Variables = vertcat(vis.Variables,vis2.Variables);
            end
            if nargin>2
                vis = merge(vis,varargin{3:end});
            end
        end
    end % methods
end % ExpressionTable class
