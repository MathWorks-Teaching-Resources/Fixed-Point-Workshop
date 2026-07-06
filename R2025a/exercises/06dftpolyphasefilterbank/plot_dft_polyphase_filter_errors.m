function t2 = plot_dft_polyphase_filter_errors(M,fs,absY,angleY,absY2,angleY2,fig) %#ok<*INUSD>
    figure(fig)
    clf
    t2 = (0:size(absY,2)-1)/(fs/M);
    rel_err = (abs(double(absY)-double(absY2)))/max(double(abs(absY2(:))));
    rel_err_db = 20*log10(rel_err);
    plot(t2,rel_err_db)
    xlabel('Time (normalized: 1 = chirp period)')
    ylabel('dB down')
    x = (0:M-1)*t2(end)/M;
    y = max(rel_err_db(:))+2;
    for i = 1:length(x)
        text(x(i),y,int2str(i),...
            'HorizontalAlignment','center')
    end
    label = 'Relative Errors';
    h = title(label);
    set(h,'Interpreter','none');
    set(fig,'Name',label,'WindowStyle','Docked');
    drawnow
end