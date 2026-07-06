function plot_filter_coefficients
    % PLOT_FILTER_COEFFICIENTS Plot FIR filter coefficients
    b = fir_filter_inputs;
    h = stem(b,'LineWidth',1.5,'MarkerSize',8);
    h.MarkerFaceColor = h.Color;
    grid on
end