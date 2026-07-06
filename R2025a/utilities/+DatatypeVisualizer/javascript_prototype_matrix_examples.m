function [PN,P,N,E] = javascript_prototype_matrix_examples(expression_location)
    warning off vision:obsolete:obsoleteFunctionality
    if nargin<1
        data_path = fullfile(filesep,'mathworks','devel','sandbox','tbryan','work','flow',...
            'features','visualize_customer_examples','iSonea',...
            'visualize_manual_conversion', ...
                             'saved_expression_tables');
        if ispc
            % Need one more for Windows
            % \\mathworks\devel\...
            data_path = [filesep,data_path];
        end
        file1 = 'Wheeze_Alg_7_1_Server_20150715T112400_scaled_double32_16.mat';
        expression_location = fullfile(data_path,file1);
    end
    if ischar(expression_location)
        S1 = load(expression_location);
        E = S1.E;
    elseif isa(expression_location,'table')
        E = expression_location;
    end
    
    [PN,P,N,E] = DatatypeVisualizer.expression_table_to_matrix(E);
    clf
    DatatypeVisualizer.plot_expression_table(E);
    
    
end