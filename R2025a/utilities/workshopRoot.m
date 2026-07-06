function workshop_root = workshopRoot
    file = mfilename('fullpath');
    filepath = fileparts(file);
    workshop_root = fullfile(filepath,'..');
end
