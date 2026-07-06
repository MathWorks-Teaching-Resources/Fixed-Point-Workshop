function plot_overflow_and_underflow(E,V,fun_name,my_title)
% Datatype visualization beta.
    
%   Tom Bryan and Julia Wall, 5 April 2015
%   Copyright 2015-2022 The MathWorks, Inc.


    if nargin<2, fun_name=''; end

%% Find range issues in Expressions
%     ExpressionUnderflow=E(E.Underflow,:);
%     ExpressionOverflow=E(E.Overflow,:);
%     ExpressionRangeIssues=[ExpressionUnderflow;ExpressionOverflow];
%     rowsE = E.Underflow==true | E.Overflow==true;
      
      rowsE = E.Underflow | E.Overflow;
      ExpressionRangeIssues = E(rowsE,:);
      
%     Sort should already be done by index. No need to re-sort
%     ExpressionRangeIssues=sortrows(ExpressionRangeIssues,1);
   
%% Find range issues in Variables
    rowsV = V.Underflow | V.Overflow;
    VariableRangeIssues = V(rowsV,:);
    
%   Sort should already be done by index. No need to re-sort
%   VariableRangeIssues=sortrows(VariableRangeIssues,1);

%% Plot Range Issues
    figure('Name','Variables with Potential Range Issues')
    if isempty(VariableRangeIssues)
        text(0.5,0.5,'NONE');
    else
        DatatypeVisualizer.plot_current_order(VariableRangeIssues);
    end
    
    figure('Name','Expressions with Potential Range Issues')
    if isempty(ExpressionRangeIssues)
        text(0.5,0.5,'NONE');
    else
        DatatypeVisualizer.plot_current_order(ExpressionRangeIssues);
    end

end
