function fir_filter_plot1(t,tchirp,x,y)
    fig = figure(1);
    clf
    linewidth = workshop.plotspec.LineWidth;
    fontsize = workshop.plotspec.FontSize;
    plot(t,x,t,y,linewidth{:})
    set(gca,fontsize{:})
    xline(tchirp(end),linewidth{:});
    text(tchirp(end)/2,-1.25,'Chirp',fontsize{:})
    text(t(end)-(t(end)-tchirp(end))/2,-1.25,'Max Gain',fontsize{:})
    title('Builtin filter',fontsize{:})
    h = legend('Chirp + Maximum Gain Signal','Filtered output',fontsize{:});
    h.Location = 'northwest';
    figure(fig)
    set(fig,'Name','Builtin','WindowStyle','Docked')
    addToolbarExplorationButtons(fig)
end