%% Create a fi object and write hex to file
a = fi(-16:16,1,8,0);
write_hex_to_file(a,'hex_file.txt');

%% Read fi object from hex file
prototype = cast([],'like',a);
b = read_hex_from_file(prototype,'hex_file.txt');

%% Verify that the write-read round trip worked
is_equal_write_read_round_trip = isequal(a(:),b(:)) %#ok<NOPTS>
