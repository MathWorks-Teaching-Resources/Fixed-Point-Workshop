function map = extend_color_map(sparse_map,map_length)
    %extend_color_map Extend a sparse color map to a full one.
    %
    %map = extend_color_map(sparse_map,map_length) 

%   Copyright 2022 The MathWorks, Inc.

    if nargin<2
        map_length = 64;
    end
    
    n_sections = size(sparse_map,1)-1;
    section_length = round(map_length/n_sections);
    
    map = zeros(map_length,3);
    for m = 1:n_sections
        section = extend_section(sparse_map(m,:),sparse_map(m+1,:),section_length);
        map(((m-1)*section_length+1):m*section_length,:) = section;
    end
    map(1,:) = sparse_map(1,:);
    map(end,:) = sparse_map(end,:);
    
end

function section = extend_section(a,b,section_length)
    section = [linspace(a(1),b(1),section_length)',...
        linspace(a(2),b(2),section_length)',...
        linspace(a(3),b(3),section_length)'];
end
