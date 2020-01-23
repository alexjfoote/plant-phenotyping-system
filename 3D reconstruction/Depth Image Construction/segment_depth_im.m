function segmented_im = segment_depth_im(depth_im, plant_point)
    x_bottom = 100;  
    x_top = 100;
    y_top = 1;
    y_bottom = 1;
    
    z_width = 500;
    
    min_threshold = plant_point - z_width;
    max_threshold = plant_point + z_width;
    
    segmented_im = depth_im(y_top:end - y_bottom, x_bottom:end - x_top);
    segmented_im(segmented_im > max_threshold | ...
        segmented_im < min_threshold) = 0;
end