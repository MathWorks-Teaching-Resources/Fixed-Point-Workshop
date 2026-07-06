function filterMovie(band)
    %filterMovie Movie of moving-average filter
    %   filterMovie - Movie of filter operating on an impulse.
    %
    %   filterMovie low - Movie of a low-pass filter operating on a chirp
    %   signal.
    %
    %   filterMovie high - Movie of a high-pass filter operating on a chirp
    %   signal.
    %
    %   filterMovie band - Movie of a band-pass filter operating on a chirp
    %   signal.

    %   Thomas A. Bryan, 14 February 2019
    %   Copyright 2019 The MathWorks, Inc.
    if nargin<1
        band = 'impulse';
    end
    warning('off','MATLAB:Figure:SetPosition');
    % Linear chirp input input
    fs = 75;
    t = (0:floor(pi*fs))/fs;
    f1 = fs/10; % Final frequency
    x = sin(pi*f1*t.^2);  % Chirp
    if isnumeric(band)
        b = band;
        title_string = "Moving Average";
    else
        % Filter design
        filter_order = 46;
        switch band
            case {'low','high'}
                b = fir1(filter_order,0.3,band);
                title_string = [upper(band(1)),lower(band(2:end)), '-Pass Moving Average' ];
            case 'band'
                low = 0.2;
                bnd = [0.3 0.9];
                b = fir1(filter_order,[low bnd]);
                title_string = 'Band-Pass Moving Average';
            otherwise
                band = 'impulse';
                % Impulse response
                b = fir1(filter_order,0.3);
                %b = b/max(abs(b));
                title_string = 'Response to Impulse is Finite';
                x = zeros(round(length(x)/2),1);
                x(1) = 1;
        end
    end
    t = (1:length(x));  % Resize to fit new x
    yLim = [-1 1];
    [~,z] = filter(b,1,x);
    y = zeros(size(x));
    z(:) = 0;
    fig = figure(1);
    set(fig,'color','w',...
        'Units','normalized',...
        'Position',[0 0 1 1]);
    clf
    k = 1;
    h2 = subplot(2,1,2);
    switch band
        case 'impulse'
            p2 = stem(t,[x,y]);
            set(p2,'LineWidth',2,'MarkerSize',8);
        otherwise
            p2 = plot(t,x,t,y);
            p2(1).LineWidth = 1;
    end
    p2(2).Color = [0.8500 0.3250 0.0980];
    p2(2).LineWidth = 4;
    xLim = h2.XLim;
    xLim(1) = xLim(1) - length(b);
    h2.XLim = xLim;
    h2.YLim = yLim;
    h2.YLimMode = "manual";
    axis off
    h1 = subplot(2,1,1);
    switch band
        case 'impulse'
            p1 = stem(k-length(b)+1:k,b);
            p1.LineWidth = p2(1).LineWidth;
            p1.MarkerSize = p2(1).MarkerSize;
        otherwise
            p1 = plot(k-length(b)+1:k,b);
            p1.Color = [0 0.4470 0.7410];
            p1.LineWidth = p2(2).LineWidth;
    end
    textYPosition = min(b)-0.5;
    %text1 = text(k-length(b)/2, textYPosition, "sum(b .* x(n:-1:n-n_b+1))");
    text1 = text(k-length(b)/2, textYPosition, "sum(b .* x(n:-1:n-length(b)+1))");
    text1.FontName = "Courier";
    text1.HorizontalAlignment = "center";
    text1.FontSize = 24;
    text1.FontWeight = "bold";
    xline1 = xline(h2,k-length(b)+1);
    xline2 = xline(h2,k);
    axis off
    h1.XLim = h2.XLim;
    h1.YLim = yLim;
    h1.YLimMode = "manual";
    h1.Title.String = [title_string,' (Press RETURN to Start)'];
    h1.Title.FontSize = 24;
    h1.Title.FontWeight = "bold";
    pause
    h1.Title.String = title_string;
    for k = 1:length(x)
        [y(k),z] = filter(b,1,x(k),z);
        p1.XData = k-length(b)+1:k;
        text1.Position = [k-length(b)/2, textYPosition];
        xline1.Value = k-length(b)+1;
        xline2.Value = k;
        p2(2).YData = y;
        drawnow
    end
    figure(fig)
end