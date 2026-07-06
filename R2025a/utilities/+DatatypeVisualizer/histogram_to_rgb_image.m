function rgb = histogram_to_rgb_image(h,log2_MaxAbsRange,log2_Eps,zero,overflow,underflow)
%

%   Copyright 2022 The MathWorks, Inc.
    
% Turn off things out of the range of the particular histogram
    base_colormap = flipud(bone);
    max_color_index = size(base_colormap,1);

    overflow_histogram = h - min(h(:));
    max_overflow_histogram = max(overflow_histogram(:));
    if max_overflow_histogram ~= 0
      % Normalize, but don't divide by zero
      overflow_histogram = overflow_histogram / max_overflow_histogram;
    end
    overflow_histogram = round(overflow_histogram * max_color_index);
    inrange_histogram = overflow_histogram;
    underflow_histogram = overflow_histogram;
    out_of_range_mask = ones(size(h));

    M = (1:256)';
    for n = 1:size(overflow_histogram,2)
        if overflow(n)
            overflow_histogram(M<log2_MaxAbsRange(n)+zero,n) = nan;
            inrange_histogram(M>=log2_MaxAbsRange(n)+zero,n) = nan;
        else
            overflow_histogram(:,n) = nan;
        end
        if underflow(n)
            underflow_histogram(M>=log2_Eps(n)+zero,n) = nan;
            inrange_histogram(M<log2_Eps(n)+zero,n) = nan;
        else
            underflow_histogram(:,n) = nan;
        end
        % out_of_range_mask:
        % The places that are out of inrange = 1
        % Everything else is nan
        % And make nan everything else that has non-nan
        % from h
        if isnan(log2_Eps(n)) || isnan(log2_MaxAbsRange(n))
            out_of_range_mask(:,n) = nan;
        else
            out_of_range_mask((M>=log2_Eps(n)+zero) & (M<=log2_MaxAbsRange(n)+zero),n) ...
                = nan; % Zero out in range
            out_of_range_mask(~isnan(h)) = nan; % Zero out anything with data
        end
    end

    % Color maps
    % Tom's original, gray out of range, white in range
    % out_of_range_colormap = [0.9 0.9 0.9];
    % in_range_no_data_colormap = [1 1 1];
    
    % Visual designer picked white background out of range,
    % gray in range.
    out_of_range_colormap = [1 1 1]; % white
    in_range_no_data_colormap = 0.9*[1 1 1]; % gray
    
    overflow_colormap = DatatypeVisualizer.red_color_map(64);
    underflow_colormap = DatatypeVisualizer.orange_color_map(64);
    inrange_colormap = DatatypeVisualizer.blue_color_map(64);

    out_of_range_rgb = ind2rgb(out_of_range_mask,out_of_range_colormap);
    overflow_rgb = ind2rgb(overflow_histogram,overflow_colormap);
    inrange_rgb = ind2rgb(inrange_histogram,inrange_colormap);
    underflow_rgb = ind2rgb(underflow_histogram,underflow_colormap);

    out_of_range_rgb = mask_rgb(out_of_range_rgb,out_of_range_mask);
    overflow_rgb = mask_rgb(overflow_rgb,overflow_histogram);
    inrange_rgb = mask_rgb(inrange_rgb,inrange_histogram);
    underflow_rgb = mask_rgb(underflow_rgb,underflow_histogram);
    
    inrange_no_data_mask = double(isnan(h) & isnan(inrange_histogram) & isnan(out_of_range_mask));
    inrange_no_data_mask(inrange_no_data_mask==0) = nan;
    inrange_no_data_rgb = ind2rgb(inrange_no_data_mask,in_range_no_data_colormap);
    inrange_no_data_rgb = mask_rgb(inrange_no_data_rgb,inrange_no_data_mask);
    
    
    rgb = out_of_range_rgb + overflow_rgb + inrange_rgb + underflow_rgb + inrange_no_data_rgb;
    
end

function rgb = mask_rgb(rgb, h)
    for p = 1:3
        rgb_slice = rgb(:,:,p);
        rgb_slice(isnan(h)) = 0;
        rgb(:,:,p) = rgb_slice;
    end
end
