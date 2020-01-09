function segmented_im = segment_depth_im(depth_im)
    x_left = 50;
    x_right = 50;
    y_top = 100;
    y_bottom = 0;
    
    min_threshold = 0;
    max_threshold = 1150;
    
    segmented_im = depth_im(y_top:end - y_bottom, x_right:end - x_left);
    segmented_im(segmented_im > max_threshold | ...
        segmented_im < min_threshold) = 0;
end