function t2 = plot_dft_polyphase_filter_outputs(M,fs,absY,angleY,fig) %#ok<INUSL>
    figure(fig)
    clf
    t2 = (0:size(absY,2)-1)/(fs/M);
    absYdb = 20*log10(double(absY));
    plot(t2,absYdb)
    ylabel('Magnitude (dB) = 20*log10(abs(Y))')
    xlabel('Time (normalized: 1 = chirp period)')
    x = (0:M-1)*t2(end)/M;
    y = max(absYdb(:))+1;
    for i = 1:length(x)
        text(x(i),y,int2str(i),...
            'HorizontalAlignment','center')
    end
    label = 'Outputs';
    h = title(label);
    set(h,'Interpreter','none');
    set(fig,'Name',label,'WindowStyle','Docked');
    drawnow
end