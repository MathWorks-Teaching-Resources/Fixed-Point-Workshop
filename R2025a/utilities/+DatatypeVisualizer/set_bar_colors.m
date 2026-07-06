function set_bar_colors(h)
% Datatype visualization beta.
    
%   Tom Bryan and Julia Wall, 5 April 2015
%   Copyright 2015-2022 The MathWorks, Inc.

    %
    Red = [255, 0, 0]/255;
    LightSalmon = [255, 160, 122]/255;
    Orchid = [218, 112, 214]/255; %#ok<NASGU>
    
    % Blues
    DodgerBlue = [30, 144, 255]/255;
    DeepSkyBlue = [0, 191, 255]/255;
    SkyBlue = [135, 206, 250]/255;
    LightSkyBlue = [135, 206, 250]/255;
    SteelBlue = [70, 130, 180]/255;
    LightSteelBlue = [176, 196, 222]/255;
    LightBlue = [173, 216, 230]/255;
    PaleTurquoise = [175, 238, 238]/255;
    DarkTurquoise = [0, 206, 209]/255;
    MediumTurquoise = [72, 209, 204]/255; %#ok<NASGU>
    Turquoise = [64, 224, 208]/255;
    
    %
    Gray = [190, 190, 190]/255;
    
    
    for n=1:length(h)
        DisplayName = get(h(n),'DisplayName');
        switch DisplayName
            case 'double'
                color = Red;
            case 'single'
                color = LightSalmon;
            case 'embedded_fi'
                color = DodgerBlue;
            case 'int64'
                color = DeepSkyBlue;
            case 'int32'
                color = SkyBlue;
            case 'int16'
                color = MediumTurquoise;
            case 'int8'
                color = SteelBlue;
            case 'uint64'
                color = LightSteelBlue;
            case 'uint32'
                color = LightBlue;
            case 'uint16'
                color = PaleTurquoise;
            case 'uint8'
                color = DarkTurquoise;
            case 'logical'
                color = Turquoise;
            case 'ScaledDouble'
                color = Red;
            case 'Fixed'
                color = DodgerBlue;
            otherwise
                color = Gray;
        end
        set(h(n),'FaceColor',color);
        set(h(n),'EdgeColor',color);
        
    end
    
end
