function  plot_rgb_to_horizontal(RGB,zero,xlimit)
% Datatype visualization beta.
    
%   Tom Bryan and Julia Wall, 5 April 2015
%   Copyright 2015-2022 The MathWorks, Inc.

    if nargin<2
        zero = 128;
    else
        zero = zero - 1;
    end
    
    if nargin<2
        xlimit = get(gca,'XLim');
    end
    Gray = 200*[1,1,1]/255;
    binary_point_color = Gray; %LightGray;
    ylim = get(gca','YLim');

    rgb = flip(permute(RGB,[2 1 3]),2);
    image(rgb);
    set(gca,'XTick',0:2:256);
    set(gca,'XTickLabel',128:-2:-128);
    set(gca,'Xlim',xlimit);
    line([zero,zero],ylim,'Color',binary_point_color);
    set(gca,'YTick',[])
    xlabel('Powers of two')

end
