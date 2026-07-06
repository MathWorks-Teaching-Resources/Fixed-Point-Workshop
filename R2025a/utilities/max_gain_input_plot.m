function max_gain = max_gain_input_plot(b)
    % MAX_GAIN_INPUT_PLOT Plot input that produces maximum gain from FIR filter
    figure
    if nargin<1
        b = fir_filter_inputs;
    end
    b = double(b);
    %     x = sign(fliplr(b));
    %     h = stem([b;x;filter(b,1,x)]','LineWidth',1.5,'MarkerSize',8);
    %     for k=1:length(h)
    %         h(k).MarkerFaceColor = h(k).Color;
    %     end
    %     legend('Coefficients','Max Gain Input','Filtered Output','FontSize',18,'Location','eastoutside')
    %
    %     fontsize = workshop.plotspec.FontSize;
    %     set(gca,fontsize{:})
    max_gain = norm(b,1);

    x = sign(fliplr(b));

    stem([b;x;filter(b,1,x)]',...
        'filled',...
        'LineWidth',1.5,'MarkerSize',8);
    legend('Coefficients','Max Gain Input','Filtered Output',...
        'Location','north')

end