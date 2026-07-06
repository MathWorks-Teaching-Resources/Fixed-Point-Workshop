classdef ExpressionTable
    properties
        E
    end
    methods
        function ET = ExpressionTable(e)
            assert(isa(e,'table'),...
                'The input to ExpressionTable must be a table object');
            % Also add assertions about the fields.
            ET.E = e;
        end
        % Since table is sealed, we either have to overload and
        % pass-through table's methods, or just let the user access ET.E.
    end
end