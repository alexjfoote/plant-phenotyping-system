function segmented_im = segment_depth_im(depth_im, plant_point)
    z_width = 500;
    
    min_threshold = plant_point - z_width;
    max_threshold = plant_point + z_width;
    
    depth_im(depth_im > max_threshold | depth_im < min_threshold) = 0;
    
    segmented_im = depth_im;
end