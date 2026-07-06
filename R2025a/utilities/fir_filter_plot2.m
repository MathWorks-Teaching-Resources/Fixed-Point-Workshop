function fir_filter_plot2(t,tchirp,x,y,y0) %#ok
    fig = figure(2);
    clf
    linewidth = workshop.plotspec.LineWidth;
    fontsize = workshop.plotspec.FontSize;
    h1 = subplot(2,1,1);
    plot(t,y0,t,y,linewidth{:})
    set(h1,fontsize{:});
    xline(tchirp(end),linewidth{:});
    text(tchirp(end)/2,-1.25,'Chirp',fontsize{:})
    text(t(end)-(t(end)-tchirp(end))/2,-1.25,'Max Gain',fontsize{:})
    title('Builtin double vs. Algorithm',fontsize{:});
    h = legend('Builtin double','Algorithm',fontsize{:});
    h.Location = 'north';
    h2 = subplot(2,1,2);
    plot(t,double(y)-double(y0),linewidth{:});
    set(h2,fontsize{:});
    xline(tchirp(end),linewidth{:});
    legend('Error',fontsize{:},'Location','north')
    linkaxes([h1,h2],'x')
    set(fig,'Name','Algorithm','WindowStyle','Docked')
    addToolbarExplorationButtons(fig)
    
end
