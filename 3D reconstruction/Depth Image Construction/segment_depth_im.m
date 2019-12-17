function segmented_im = segment_depth_im(depth_im)
    x_min = 40;
    x_max = 400;
    y_min = 100;
    
    above_z_min = 0;
    above_z_diff = 1400;
    below_z_min = 0;
    below_z_diff = 1150;
    
    pot_top = 320;
    
    above_segment = depth_im(y_min:pot_top, x_min:x_max);
    below_segment = depth_im(pot_top + 1:end, x_min:x_max);
    
    above_segment(above_segment < above_z_min | ...
        above_segment > above_z_min + above_z_diff) = 0;
    below_segment(below_segment < below_z_min | ...
        below_segment > below_z_min + below_z_diff) = 0;
    
    segmented_im = [above_segment; below_segment];
end