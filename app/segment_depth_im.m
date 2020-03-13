function segmented_im = segment_depth_im(depth_im, min_threshold, max_threshold)
    % Returns a segmented depth image with the foreground and background
    % removed based on the specified thresholds

    depth_im(depth_im > max_threshold | depth_im < min_threshold) = 0;
    
    segmented_im = depth_im;
end