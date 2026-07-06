function c = merge_arrays(a,b)
    % MERGE_ARRAYS Merge two arrays m-by-3 arrays based on their first
    % column as an index.
    %
    % Example:
    % a = int32([-10 3 4
    %     -5 6 7
    %     8 9 10
    %     11 12 13]);
    %
    % b = int32([-11 2 3
    %     -5 1 2
    %     11 3 4
    %     12 13 14]);
    %
    % c = merge_arrays(a,b)

%   Copyright 2022 The MathWorks, Inc.
    
    % Tom Bryan, 18 February 2016
    
    assert(ismatrix(a) && ismatrix(b) && size(a,2)==size(b,2),...
        'The inputs must be matrices with the same number of columns');
    
    % The first column is the index.
    a1 = a(:,1);
    b1 = b(:,1);
    
    % Create the first column of the merged array from the first columns of
    % the inputs.
    c1 = union(a1,b1);
    % Initialize the output array such that the first column is merged and
    % the remaining columns are zeros.
    c = [c1,zeros(size(c1,1),size(a,2)-1)];
    
    % Find the indices where the output and inputs intersect.
    [~,ica,ia] = intersect(c1,a1);
    [~,icb,ib] = intersect(c1,b1);
    
    % Assign the first array into the output.
    c(ica,2:end) = a(ia,2:end);
    
    % Sum the second array into the output.
    c(icb,2:end) = c(icb,2:end)+b(ib,2:end);
end
