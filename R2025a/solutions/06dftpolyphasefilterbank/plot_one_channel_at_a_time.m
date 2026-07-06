function plot_one_channel_at_a_time(M,fs,Y,fig)
    t2 = (0:size(Y,2)-1)/(fs/M);
        figure(fig)
        set(fig,'Name','Channel','WindowStyle','Docked');
        clf
    for i = 1:size(Y,1)
        plot(t2,20*log10(double(Y(i,:))));
        ylabel('Magnitude (dB) = 20*log10(abs(Y))')
        xlabel('Time (normalized: 1 = chirp period)')
        figure(gcf)
        title(['Channel ',int2str(i),' (Press any key to continue)']);
        pause
    end
end