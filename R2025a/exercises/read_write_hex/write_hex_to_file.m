function write_hex_to_file(a,filename)
    % write_hex_to_file Write hex values from fi object to file
    %
    % write_hex_to_file(a,filename) writes hex values from fi object a to
    % file named filename.
    assert(isfi(a),'Input must be a fi object');
    % Create hex column vector
    h = hex(a(:));
    fid = fopen(filename,'w');
    % Write hex to the file one row at a time
    for i = 1:numel(a)
        fprintf(fid, '0x%s\n', h(i,:));
    end
    fclose(fid);
end