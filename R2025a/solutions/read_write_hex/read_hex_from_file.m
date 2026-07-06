function b = read_hex_from_file(prototype, filename)
    % read_hex_from_file Reads hex values from file
    %
    % read_hex_from_file(prototype, filename) reads hex values from file
    % filename and casts them to a fi object with the properties of
    % prototype.
    assert(isfi(prototype),'Input must be a fi object');
    
    fid = fopen(filename,'r');
    h = textscan(fid,'0x%s');
    fclose(fid);
    b = zeros(size(h{1}),'like',prototype);
    b.hex = char(h{1});
end