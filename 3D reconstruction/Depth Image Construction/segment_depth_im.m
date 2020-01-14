function segmented_im = segment_depth_im(depth_im, plant_point)
    x_left = 70;    
    x_right = 70;    
    y_top = 1;
    y_bottom = 1;
    
    min_threshold = plant_point - 300;
    max_threshold = plant_point + 300;
    
    segmented_im = depth_im(y_top:end - y_bottom, x_left:end - x_right);
    segmented_im(segmented_im > max_threshold | ...
        segmented_im < min_threshold) = 0;
end